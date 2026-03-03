"""CLI for Project Thor."""

import argparse
from pathlib import Path

from thor.orchestrator import run_scan
from thor.agents.action import ReportAgent, AlertAgent


def _print_table(rows, headers):
    """Simple table print."""
    widths = [max(len(str(r[i])) for r in [headers] + rows) for i in range(len(headers))]
    fmt = "  ".join(f"{{:<{w}}}" for w in widths)
    print(fmt.format(*headers))
    print("-" * (sum(widths) + 2 * (len(headers) - 1)))
    for row in rows:
        print(fmt.format(*[str(x)[:60] + "..." if len(str(x)) > 60 else str(x) for x in row]))


def cmd_scan(args):
    """Scan business data and run compliance checks."""
    print("\nScanning...")
    snapshot, report = run_scan(source=args.source)

    print(f"\nSnapshot: {snapshot.source}")
    print(f"  Products: {len(snapshot.products)}")
    print(f"  Prices: {len(snapshot.pricing)}")

    rows = [(c.name, c.regulation, c.status.value, c.finding) for c in report.checks]
    _print_table(rows, ["Check", "Regulation", "Status", "Finding"])

    print(f"\nOverall: {report.overall_status.value.upper()}")
    print(f"Summary: {report.summary}")

    alert_agent = AlertAgent()
    alerts = alert_agent.get_alerts(report.checks)
    if alerts:
        print("\n[!] Alerts:")
        for a in alerts:
            print(f"  - {a['title']} ({a['regulation']})")
            print(f"    {a['recommendation']}")

    report_agent = ReportAgent()
    if args.output:
        Path(args.output).write_text(report_agent.to_json(report), encoding="utf-8")
        print(f"\n[OK] JSON saved to {args.output}")
    if args.pdf:
        report_agent.to_pdf(report, args.pdf)
        print(f"[OK] PDF saved to {args.pdf}")


def cmd_report(args):
    """Generate compliance report."""
    print("\nGenerating report...")
    _, report = run_scan(source=args.source)
    report_agent = ReportAgent()

    if args.format == "json":
        out = f"compliance_report_{report.generated_at.strftime('%Y%m%d_%H%M')}.json"
        Path(out).write_text(report_agent.to_json(report), encoding="utf-8")
        print(f"[OK] Report saved to {out}")
    elif args.format == "pdf":
        out = f"compliance_report_{report.generated_at.strftime('%Y%m%d_%H%M')}.pdf"
        report_agent.to_pdf(report, out)
        print(f"[OK] Report saved to {out}")
    else:
        print(f"Unknown format: {args.format}")
        raise SystemExit(1)


def main():
    parser = argparse.ArgumentParser(prog="thor", description="Agentic Compliance Layer")
    sub = parser.add_subparsers(dest="cmd", required=True)

    scan_p = sub.add_parser("scan", help="Scan business data and run compliance checks")
    scan_p.add_argument("--source", "-s", default="stripe", help="Data source: stripe, shopify")
    scan_p.add_argument("--output", "-o", help="Save report as JSON")
    scan_p.add_argument("--pdf", help="Save report as PDF")
    scan_p.set_defaults(func=cmd_scan)

    report_p = sub.add_parser("report", help="Generate compliance report")
    report_p.add_argument("--format", "-f", default="json", choices=["json", "pdf"])
    report_p.add_argument("--source", "-s", default="stripe")
    report_p.set_defaults(func=cmd_report)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()

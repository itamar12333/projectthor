"""Orchestrates agents: ingestion -> compliance -> report."""

from thor.agents.compliance import GDPRComplianceAgent
from thor.agents.ingestion import StripeIngestionAgent, ShopifyIngestionAgent
from thor.agents.action import ReportAgent
from thor.core.config import get_settings
from thor.core.models import BusinessSnapshot, ComplianceReport


def run_scan(source: str = "stripe") -> tuple[BusinessSnapshot, ComplianceReport]:
    """Run full scan: ingest data, check compliance, build report."""
    settings = get_settings()

    # 1. Ingest
    if source == "stripe":
        agent = StripeIngestionAgent(api_key=settings.stripe_secret_key)
    elif source == "shopify":
        agent = ShopifyIngestionAgent(
            store_url=settings.shopify_store_url,
            access_token=settings.shopify_access_token,
        )
    else:
        raise ValueError(f"Unknown source: {source}. Supported: stripe, shopify")

    snapshot = agent.scan()
    business_name = snapshot.metadata.get("business_name", "Your Business")

    # 2. Compliance check
    compliance_agent = GDPRComplianceAgent()
    checks = compliance_agent.check(snapshot)

    # 3. Report
    report_agent = ReportAgent()
    report = report_agent.build_report(checks, business_name=business_name)

    return snapshot, report

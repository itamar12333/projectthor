"""Generate policy templates based on compliance findings."""

try:
    from thor.orchestrator import run_scan
    from thor.agents.action import ToSUpdateAgent
except ImportError as e:
    print("ERROR: Missing package. Run: python -m pip install pydantic --user")
    print(f"Details: {e}")
    input("Press Enter to exit...")
    exit(1)

print("=" * 60)
print("  Generating Policy Templates")
print("=" * 60)
print()

try:
    # Run scan
    print("Scanning business data...")
    snapshot, report = run_scan(source="stripe")
    print(f"Found {len(report.checks)} compliance checks\n")

    # Generate ToS updates
    tos_agent = ToSUpdateAgent()
    updates = tos_agent.generate_updates(report.checks, snapshot)

    if not updates:
        print("No policy updates needed at this time.")
    else:
        print(f"Generated {len(updates)} policy templates:\n")
        
        for i, update in enumerate(updates, 1):
            print("=" * 60)
            print(f"{i}. {update['title']}")
            print("=" * 60)
            print(f"Type: {update['type']}")
            print(f"Recommendation: {update['recommendation']}")
            print("\nTemplate Content:")
            print("-" * 60)
            print(update['content'])
            print("-" * 60)
            print()
            
            # Save to file
            filename = f"{update['type']}_template.txt"
            with open(filename, "w", encoding="utf-8") as f:
                f.write(update['content'])
            print(f"[OK] Saved to: {filename}\n")

        print("=" * 60)
        print("Done!")
        print("=" * 60)
except Exception as e:
    print(f"\nERROR: {e}")
    import traceback
    traceback.print_exc()
finally:
    input("\nPress Enter to exit...")

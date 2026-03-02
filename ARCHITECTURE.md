# Project Thor - Architecture

## Overview

Project Thor is an **Agentic Compliance Layer** that autonomously scans businesses, monitors regulatory changes, and generates compliance reports.

## Agent Architecture

### 1. Ingestion Agents (`thor/agents/ingestion/`)

**Purpose**: Extract business data from various sources.

- **StripeIngestionAgent**: Connects to Stripe API, extracts products, prices, account info
- **ShopifyIngestionAgent**: Connects to Shopify Admin API, extracts products, prices, policies

**Output**: `BusinessSnapshot` - structured data about the business

### 2. Compliance Agents (`thor/agents/compliance/`)

**Purpose**: Check business data against regulations.

- **GDPRComplianceAgent**: Checks GDPR, EU Consumer Rights, ePrivacy compliance
  - Privacy policy presence
  - Refund/return policy
  - Cookie consent mechanism
  - Product descriptions
  - Price transparency

**Output**: `list[ComplianceCheck]` - list of compliance findings

### 3. Monitoring Agents (`thor/agents/monitoring/`)

**Purpose**: Monitor regulatory changes in real-time.

- **LawMonitorAgent**: 
  - Scans RSS feeds (EU Official Journal, etc.)
  - Detects regulation mentions (GDPR, CCPA, French Consumer Law)
  - Assesses severity
  - Generates alerts

**Output**: `list[LawChange]` - detected law changes

### 4. Action Agents (`thor/agents/action/`)

**Purpose**: Generate reports, alerts, and updates.

- **ReportAgent**: Creates compliance reports (JSON/PDF)
- **AlertAgent**: Extracts critical alerts from compliance checks
- **ToSUpdateAgent**: Generates ToS/policy templates and update recommendations

## Data Flow

```
┌─────────────────┐
│  Data Sources   │
│  (Stripe/       │
│   Shopify)      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Ingestion Agent │ ──► BusinessSnapshot
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Compliance Agent│ ──► ComplianceCheck[]
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Report Agent   │ ──► ComplianceReport
└─────────────────┘
```

## Orchestration

**`thor/orchestrator.py`**: Coordinates the agent pipeline:

1. Select ingestion agent based on source
2. Run compliance checks
3. Build report
4. Return snapshot + report

## Web UI

**`thor/web/app.py`**: Flask application with REST API:

- `GET /` - Dashboard UI
- `POST /api/scan` - Run compliance scan
- `GET /api/report` - Get latest report
- `GET /api/alerts` - Get compliance + law alerts
- `POST /api/tos-updates` - Generate ToS update recommendations
- `GET /api/law-changes` - Get recent law changes

## CLI

**`thor/cli.py`**: Command-line interface:

- `thor scan` - Run scan and display results
- `thor report` - Generate compliance report

## Configuration

**`thor/core/config.py`**: Loads settings from `.env`:

- Stripe API keys
- Shopify credentials
- OpenAI API key (optional)

## Models

**`thor/core/models.py`**: Pydantic models:

- `BusinessSnapshot` - Business data from ingestion
- `ComplianceCheck` - Single compliance finding
- `ComplianceReport` - Full compliance report
- `LawChange` - Detected law change

## Extensibility

### Adding New Data Sources

1. Create new agent in `thor/agents/ingestion/`
2. Implement `scan()` method returning `BusinessSnapshot`
3. Add to orchestrator

### Adding New Regulations

1. Create new agent in `thor/agents/compliance/`
2. Implement `check()` method returning `list[ComplianceCheck]`
3. Add to orchestrator

### Adding New Monitoring Sources

1. Add RSS feed URL to `LawMonitorAgent.rss_feeds`
2. Or implement custom API monitoring

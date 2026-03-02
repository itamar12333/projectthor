# Project Thor - Quick Start Guide

## התקנה מהירה

```bash
# 1. התקן תלויות
pip install -r requirements.txt

# 2. הגדר משתני סביבה
cp .env.example .env
# ערוך .env והוסף את המפתחות שלך
```

## שימוש ב-CLI

```bash
# סריקת Stripe
python -m thor.cli scan --source stripe

# סריקת Shopify
python -m thor.cli scan --source shopify

# יצירת דוח PDF
python -m thor.cli report --format pdf

# שמירת דוח JSON
python -m thor.cli scan -o report.json
```

## שימוש ב-Web Dashboard

```bash
# הפעל את השרת
python -m thor.web.run

# פתח בדפדפן
# http://localhost:5000
```

בדשבורד תוכל:
- ✅ להריץ סריקות בזמן אמת
- ✅ לראות התראות תקינות
- ✅ לעקוב אחר שינויי חוקים
- ✅ לקבל המלצות לעדכון ToS
- ✅ להוריד דוחות PDF/JSON

## דוגמאות שימוש

### 1. סריקה בסיסית

```python
from thor.orchestrator import run_scan

snapshot, report = run_scan(source="stripe")
print(f"Status: {report.overall_status}")
print(f"Checks: {len(report.checks)}")
```

### 2. מעקב אחר חוקים

```python
from thor.agents.monitoring import LawMonitorAgent

monitor = LawMonitorAgent()
changes = monitor.check_rss_feeds()
alerts = monitor.generate_alerts(changes)
```

### 3. יצירת עדכוני ToS

```python
from thor.agents.action import ToSUpdateAgent
from thor.orchestrator import run_scan

snapshot, report = run_scan(source="stripe")
tos_agent = ToSUpdateAgent()
updates = tos_agent.generate_updates(report.checks, snapshot)

for update in updates:
    print(f"{update['title']}: {update['recommendation']}")
```

## תמיכה

- 📖 [README.md](README.md) - תיעוד מלא
- 🏗️ [ARCHITECTURE.md](ARCHITECTURE.md) - ארכיטקטורה מפורטת

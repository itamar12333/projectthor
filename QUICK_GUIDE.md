# 🚀 מדריך מהיר - Project Thor

## ✅ מה כבר מוכן?

### 1. דוח JSON נוצר!
📄 **קובץ**: `compliance_report.json`
- מכיל את כל תוצאות הסריקה
- מוכן לשליחה לבנקים/משקיעים

### 2. תבניות למדיניות נוצרו!
📄 **קבצים**:
- `refund_policy_template.txt` - מדיניות החזרות (GDPR compliant)
- `privacy_policy_template.txt` - מדיניות פרטיות (GDPR compliant)

## 🎯 איך להשתמש?

### אפשרות 1: הרצה מהירה (CLI)
**לחץ פעמיים על**: `RUN_SIMPLE.bat`

### אפשרות 2: יצירת תבניות למדיניות
**לחץ פעמיים על**: `GENERATE_POLICIES.py`
או הרץ:
```powershell
python GENERATE_POLICIES.py
```

### אפשרות 3: Web Dashboard
**לחץ פעמיים על**: `START_DASHBOARD.bat`
אז פתח דפדפן: http://localhost:5000

## 📋 מה התוכנה עושה?

1. **סורקת** את העסק שלך (Stripe/Shopify)
2. **בודקת** תקינות מול GDPR וחוקים אירופיים
3. **יוצרת** דוחות JSON/PDF
4. **מציעה** תבניות למדיניות פרטיות/החזרות
5. **מעקבת** אחר שינויי חוקים

## 🔧 פקודות שימושיות

```powershell
# סריקה בסיסית
python -m thor.cli scan --source stripe

# דוח JSON
python -m thor.cli scan --source stripe -o report.json

# יצירת תבניות
python GENERATE_POLICIES.py

# Web Dashboard
python -m thor.web.run
```

## 📁 קבצים חשובים

- `RUN_SIMPLE.bat` - הרצה מהירה
- `GENERATE_POLICIES.py` - יצירת תבניות
- `START_DASHBOARD.bat` - Web Dashboard
- `compliance_report.json` - דוח תקינות
- `*.txt` - תבניות למדיניות

## ❓ בעיות?

אם יש שגיאה:
1. ודא ש-Python מותקן: `python --version`
2. נסה: `python -m pip install pydantic --user`
3. פתח PowerShell כמנהל אם יש בעיות הרשאות

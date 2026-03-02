# מדריך הפעלה - Project Thor

## שלב 1: התקנת תלויות

פתח PowerShell או Command Prompt בתיקיית הפרויקט:

```powershell
cd c:\Users\itamar\Desktop\Project-Thor

# בדוק שיש לך Python מותקן
python --version

# התקן את כל התלויות
pip install -r requirements.txt
```

**אם יש שגיאות**, נסה:
```powershell
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

## שלב 2: הגדרת משתני סביבה

1. **העתק את קובץ הדוגמה**:
```powershell
copy .env.example .env
```

2. **ערוך את הקובץ `.env`** והוסף את המפתחות שלך:

```env
# Stripe (חובה אם אתה משתמש ב-Stripe)
STRIPE_SECRET_KEY=sk_test_המפתח_שלך_כאן

# Shopify (חובה אם אתה משתמש ב-Shopify)
SHOPIFY_STORE_URL=https://your-store.myshopify.com
SHOPIFY_ACCESS_TOKEN=shpat_המפתח_שלך_כאן

# OpenAI (אופציונלי - לא חובה)
OPENAI_API_KEY=sk-...
```

**איך להשיג מפתחות:**
- **Stripe**: https://dashboard.stripe.com/apikeys
- **Shopify**: https://shopify.dev/docs/apps/tools/cli/authentication

## שלב 3: הפעלה

### אופציה A: שימוש ב-CLI (Command Line)

```powershell
# סריקת Stripe
python -m thor.cli scan --source stripe

# סריקת Shopify
python -m thor.cli scan --source shopify

# יצירת דוח JSON
python -m thor.cli scan --source stripe -o report.json

# יצירת דוח PDF (דורש reportlab)
python -m thor.cli report --format pdf
```

### אופציה B: Web Dashboard (מומלץ!)

```powershell
# הפעל את השרת
python -m thor.web.run
```

אז:
1. פתח דפדפן
2. לך לכתובת: **http://localhost:5000**
3. תראה את הדשבורד המלא!

**בדשבורד תוכל:**
- ✅ להריץ סריקות בזמן אמת
- ✅ לראות התראות תקינות
- ✅ לעקוב אחר שינויי חוקים
- ✅ לקבל המלצות לעדכון ToS
- ✅ להוריד דוחות

## פתרון בעיות

### שגיאה: "ModuleNotFoundError"
```powershell
pip install -r requirements.txt
```

### שגיאה: "STRIPE_SECRET_KEY not configured"
- ודא שיצרת קובץ `.env`
- ודא שהמפתח נכון בקובץ `.env`
- ודא שאתה בתיקיית הפרויקט

### שגיאה: "Port 5000 already in use"
```powershell
# שנה את הפורט בקובץ thor/web/run.py
# או עצור את התהליך שמריץ על פורט 5000
```

### Windows: שגיאת encoding עם עברית
- השתמש ב-PowerShell או Command Prompt
- אם יש בעיות, הפעל דרך Web Dashboard

## דוגמאות שימוש

### סריקה מהירה ללא מפתחות
```powershell
# זה יעבוד גם בלי מפתחות (אבל יחזיר שגיאות)
python -m thor.cli scan --source stripe
```

### יצירת דוח מלא
```powershell
python -m thor.cli scan --source stripe -o compliance_report.json
```

### בדיקת חוקים חדשים
```powershell
# דרך Web Dashboard - לחץ על "Law Changes"
# או דרך Python:
python -c "from thor.agents.monitoring import LawMonitorAgent; m = LawMonitorAgent(); print(m.check_rss_feeds())"
```

## צעדים הבאים

1. ✅ התקן תלויות
2. ✅ הגדר `.env`
3. ✅ הפעל Web Dashboard
4. ✅ הרץ סריקה ראשונה
5. ✅ בדוק את הדוחות וההתראות

**הכל מוכן?** הפעל: `python -m thor.web.run`

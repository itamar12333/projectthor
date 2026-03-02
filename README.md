# Project Thor — Agentic Compliance Layer

> שכבת הגנה אוטונומית לסריקת העסק, התאמת רגולציה בזמן אמת והנפקת דוחות תקינות.

## חזון

מערכת מבוססת Agentic AI שסורקת את העסק (אתר, מוצרים, חוזים), מתחברת ל-Stripe/Shopify, ומעדכנת אוטומטית את תנאי השימוש בהתאם לשינויי חוק — כולל התראות ודוחות תקינות.

## ארכיטקטורה

```
thor/
├── agents/           # סוכנים אוטונומיים
│   ├── ingestion/    # חיבור ל-Stripe, Shopify
│   ├── compliance/   # בדיקת תקינות מול רגולציה
│   ├── monitoring/   # מעקב אחר שינויי חוקים
│   └── action/       # עדכונים, התראות, דוחות
├── core/             # מודלים, config, orchestration
├── web/              # Web UI - דשבורד
└── cli.py            # Command-line interface
```

## התקנה

```bash
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
```

## הגדרה

צור קובץ `.env` או `.env.local` (העתק מ-`.env.example`):
```
# לסריקת אתר (דשבורד) - חובה
OPENAI_API_KEY=sk-...
FIRECRAWL_API_KEY=fc-...

# אופציונלי
STRIPE_SECRET_KEY=sk_test_...
SHOPIFY_STORE_URL=...
SHOPIFY_ACCESS_TOKEN=...
```
**חשוב:** אל תעלה מפתחות API ל-Git. השתמש רק ב-`.env` מקומית.

## הרצה

### CLI

```bash
# סריקה מלאה + דוח
python -m thor.cli scan --source stripe
python -m thor.cli scan --source shopify

# דוח תקינות בלחיצת כפתור
python -m thor.cli report --format pdf
python -m thor.cli report --format json
```

### Web Dashboard (סריקת אתר + AI)

1. הגדר ב-`.env`: `OPENAI_API_KEY`, `FIRECRAWL_API_KEY`
2. הפעל: `OPEN_DASHBOARD.bat` או `python -m thor.web.run`
3. בדפדפן: הזן URL ולחץ "סרוק עכשיו" — המערכת תסרוק את האתר (Firecrawl), תנתח עם GPT-4o ותציג ציון, רמת סיכון, ממצאים וסעיפים חסרים.

### Web Dashboard (Stripe/Shopify)

```bash
# הפעלת שרת Web
python -m thor.web.run

# פתח בדפדפן: http://localhost:5000
```

### שיתוף עם ngrok (להצגה לחברים)

כדי לחשוף את האתר באינטרנט זמנית (למשל להראות לחברים):

1. **התקן ngrok** (אם עדיין לא): [ngrok.com/download](https://ngrok.com/download) או `choco install ngrok` ב-Windows.
2. **הפעל את השרת** במחשב שלך:
   ```bash
   python -m thor.web.run
   ```
3. **בטרמינל נפרד** הרץ:
   ```bash
   ngrok http 5000
   ```
4. ngrok יציג כתובת כמו `https://xxxx-xx-xx.ngrok-free.app` — **שתף את הכתובת הזו**. חברים יוכלו להיכנס, להירשם ולנסות את הסריקה.

**הערה:** האפליקציה מוגדרת לעבוד מאחורי proxy (ProxyFix), כך שקישורי התחברות וקישורי אימייל יעבדו עם כתובת ה-ngrok. בחשבון ngrok חינם הכתובת משתנה בכל הפעלה.

הדשבורד מאפשר:
- סריקת עסק בזמן אמת
- הצגת התראות תקינות
- מעקב אחר שינויי חוקים
- המלצות לעדכון ToS/מדיניות
- יצירת דוחות PDF/JSON

## תכונות

### ✅ מימוש מלא

- **חיבור ל-Stripe** - סריקת מוצרים, מחירים, חשבון
- **חיבור ל-Shopify** - סריקת חנות, מוצרים, מדיניות
- **בדיקות GDPR** - מדיניות החזרות, פרטיות, cookies, תיאורי מוצרים
- **יצירת דוחות** - JSON/PDF לבנקים ומשקיעים
- **התראות** - התראות על בעיות קריטיות עם המלצות
- **מעקב חוקים** - RSS feeds לשינויי רגולציה (GDPR, CCPA, חוק צרפתי)
- **עדכון ToS** - יצירת תבניות למדיניות פרטיות/החזרות/עוגיות
- **Web Dashboard** - ממשק ווב מלא להצגת דוחות והתראות

### 🔜 תכונות עתידיות

- אינטגרציה ישירה ל-CMS (WordPress, Shopify Admin API)
- עדכון אוטומטי של ToS באתר
- Webhooks לשינויי חוקים
- תמיכה ברגולציות נוספות (CCPA, LGPD, וכו')

## רישיון

MIT

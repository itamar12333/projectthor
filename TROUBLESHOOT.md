# פתרון בעיות - Project Thor

## מה לא עובד? בחר את הבעיה:

---

### 1. "Python is not recognized" / Python לא מזוהה

**פתרון:**
1. הורד Python: https://www.python.org/downloads/
2. בהתקנה - **חשוב**: סמן V ב-"Add Python to PATH"
3. הפעל מחדש את המחשב
4. נסה שוב

---

### 2. "ModuleNotFoundError: No module named 'pydantic'"

**פתרון - הרץ ב-PowerShell:**
```powershell
cd c:\Users\itamar\Desktop\Project-Thor
python -m pip install pydantic --user
```

**או** לחץ פעמיים על: `FIX_AND_RUN.bat` - הוא יתקין אוטומטית

---

### 3. החלון נסגר מהר מדי / לא רואה כלום

**פתרון:** השתמש בקבצים החדשים:
- `FIX_AND_RUN.bat` - סריקה (החלון נשאר פתוח)
- `RUN_GENERATE_POLICIES.bat` - יצירת תבניות (החלון נשאר פתוח)

---

### 4. "No module named 'flask'" - Web Dashboard לא עובד

**פתרון:**
```powershell
python -m pip install flask --user
```

---

### 5. שגיאות עברית / תווים מוזרים

**פתרון:** הקבצים `FIX_AND_RUN.bat` ו-`RUN_GENERATE_POLICIES.bat` משתמשים ב-UTF-8.
אם עדיין יש בעיה - הרץ ישירות:
```powershell
cd c:\Users\itamar\Desktop\Project-Thor
python -m thor.cli scan --source stripe
```

---

### 6. "Access Denied" / הרשאות

**פתרון:** פתח PowerShell **כמנהל** (Right-click -> Run as administrator):
```powershell
cd c:\Users\itamar\Desktop\Project-Thor
python -m pip install pydantic flask --user
```

---

### 7. איך להריץ - סיכום

| מה רוצה לעשות | מה ללחוץ |
|---------------|----------|
| סריקה בסיסית | `FIX_AND_RUN.bat` |
| יצירת תבניות למדיניות | `RUN_GENERATE_POLICIES.bat` |
| Web Dashboard | `START_DASHBOARD.bat` |

---

### 8. עדיין לא עובד?

הרץ את זה ב-PowerShell והעתק את השגיאה המלאה:

```powershell
cd c:\Users\itamar\Desktop\Project-Thor
python -m thor.cli scan --source stripe
```

שלח את השגיאה כדי שאוכל לעזור.

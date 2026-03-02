# Supabase Setup Guide

## שלב 1: יצירת פרויקט ב-Supabase

1. היכנס ל-[supabase.com](https://supabase.com)
2. צור חשבון חדש או התחבר
3. לחץ על "New Project"
4. מלא את הפרטים:
   - **Name**: Project Thor
   - **Database Password**: בחר סיסמה חזקה (שמור אותה!)
   - **Region**: בחר את האזור הקרוב אליך
5. לחץ על "Create new project"

## שלב 2: קבלת ה-API Keys

לאחר יצירת הפרויקט:

1. לך ל-**Settings** → **API**
2. תמצא שני ערכים חשובים:
   - **Project URL** - זה ה-`SUPABASE_URL`
   - **anon public** key - זה ה-`SUPABASE_KEY` (השתמש ב-anon key, לא ב-service_role)

## שלב 3: יצירת הטבלאות

לך ל-**SQL Editor** ב-Supabase והרץ את ה-SQL הבא:

```sql
-- טבלת משתמשים
CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT,
    scans_used INTEGER DEFAULT 0,
    subscribed BOOLEAN DEFAULT FALSE,
    plan TEXT DEFAULT 'free',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- טבלת reset tokens
CREATE TABLE IF NOT EXISTS reset_tokens (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    token TEXT UNIQUE NOT NULL,
    email TEXT NOT NULL,
    expires_at BIGINT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- יצירת אינדקסים לביצועים טובים יותר
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_reset_tokens_token ON reset_tokens(token);
CREATE INDEX IF NOT EXISTS idx_reset_tokens_email ON reset_tokens(email);

-- RLS (Row Level Security) - אפשר גישה לכל המשתמשים
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE reset_tokens ENABLE ROW LEVEL SECURITY;

-- מדיניות: כל אחד יכול לקרוא ולכתוב (אפשר לשנות אחר כך)
CREATE POLICY "Allow all operations on users" ON users
    FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on reset_tokens" ON reset_tokens
    FOR ALL USING (true) WITH CHECK (true);
```

## שלב 4: עדכון קובץ .env

פתח את קובץ `.env` והוסף:

```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_KEY=your-anon-public-key-here
```

החלף:
- `your-project-id` - ה-ID של הפרויקט שלך
- `your-anon-public-key-here` - ה-anon public key מ-Settings → API

## (אופציונלי) עדכון לטבלה קיימת – שדה plan

אם הטבלה `users` כבר קיימת בלי השדה `plan`, הרץ ב-SQL Editor:

```sql
ALTER TABLE users ADD COLUMN IF NOT EXISTS plan TEXT DEFAULT 'free';
```

## שלב 5: התקנת הספרייה

הרץ:
```bash
pip install supabase
```

או:
```bash
python -m pip install supabase
```

## שלב 6: בדיקה

הפעל מחדש את השרת ונסה ליצור משתמש חדש. המשתמש אמור להישמר ב-Supabase!

## הערות חשובות:

1. **אבטחה**: כרגע הסיסמאות נשמרות כטקסט פשוט. בייצור, חשוב להשתמש ב-hashing (bcrypt/argon2).

2. **RLS**: המדיניות הנוכחית מאפשרת גישה לכולם. בייצור, כדאי להגדיר מדיניות יותר מחמירה.

3. **גיבוי**: Supabase מבצע גיבויים אוטומטיים, אבל כדאי גם לשמור גיבוי ידני מדי פעם.

4. **Fallback**: המערכת תתפקד גם בלי Supabase (תשתמש ב-JSON files) אם ה-URL או ה-Key לא מוגדרים.

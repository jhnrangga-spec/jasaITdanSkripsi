-- ============================================================
-- Jalankan script ini di Supabase > SQL Editor
-- ============================================================

-- 1. Tabel orders — menyimpan setiap form order dari website
CREATE TABLE IF NOT EXISTS orders (
  id         BIGSERIAL PRIMARY KEY,
  nama       TEXT NOT NULL,
  whatsapp   TEXT NOT NULL,
  email      TEXT,
  layanan    TEXT NOT NULL,
  deskripsi  TEXT,
  status     TEXT NOT NULL DEFAULT 'baru',   -- baru | diproses | selesai | batal
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Row Level Security — wajib aktifkan agar aman
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 3. Policy: siapa saja (anon) boleh INSERT, tidak bisa SELECT/UPDATE/DELETE
CREATE POLICY "allow_insert_for_all" ON orders
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- 4. Policy: hanya authenticated user (Anda) yang bisa membaca semua order
CREATE POLICY "allow_select_for_authenticated" ON orders
  FOR SELECT
  TO authenticated
  USING (true);

-- 5. Policy: hanya authenticated user yang bisa update status order
CREATE POLICY "allow_update_status_for_authenticated" ON orders
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- ============================================================
-- Setelah selesai, salin nilai berikut dari:
-- Supabase Dashboard > Settings > API
--   • Project URL  → SUPABASE_URL di index.html
--   • anon / public key → SUPABASE_ANON_KEY di index.html
-- ============================================================

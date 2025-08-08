-- Jobs (one per CSV upload)
CREATE TABLE IF NOT EXISTS jobs (
  id TEXT PRIMARY KEY,
  created_at TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  filename TEXT,
  status TEXT DEFAULT 'pending',
  total_rows INTEGER DEFAULT 0,
  done_rows INTEGER DEFAULT 0,
  source_headers TEXT,
  error TEXT
);

CREATE TABLE IF NOT EXISTS rows (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  job_id TEXT,
  siret TEXT,
  status TEXT DEFAULT 'queued',
  payload TEXT,
  source_row TEXT,
  error TEXT,
  UNIQUE(job_id, siret)
);

CREATE INDEX IF NOT EXISTS idx_rows_job_status ON rows(job_id, status);

export const SCHEMA_VERSION = 1;

/**
 * Initial schema — create your tables here.
 *
 * Guidelines:
 * - Use TEXT PRIMARY KEY with UUID (not auto-increment)
 * - Use TEXT for dates (ISO 8601)
 * - Use INTEGER for booleans (0/1)
 * - Use REAL for floats
 * - Always add created_at / updated_at
 * - Add indexes for columns used in WHERE / ORDER BY
 */
export const schemaV1 = `
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS items (
  id TEXT PRIMARY KEY NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  title TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'active'
);

CREATE INDEX IF NOT EXISTS idx_items_updated_at ON items(updated_at);
`;

// --- Future schema versions ---
// export const schemaV2 = `...`;

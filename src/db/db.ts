import * as SQLite from 'expo-sqlite';

import { SCHEMA_VERSION, schemaV1 } from './schema';

let dbPromise: Promise<SQLite.SQLiteDatabase> | null = null;

/**
 * Check whether a column exists on a table.
 * Useful for idempotent ALTER TABLE migrations (SQLite has no IF NOT EXISTS).
 */
async function hasColumn(db: SQLite.SQLiteDatabase, table: string, column: string) {
  const cols = await db.getAllAsync<{ name: string }>(`PRAGMA table_info(${table});`);
  return cols.some((c) => c.name === column);
}

async function migrate(db: SQLite.SQLiteDatabase) {
  await db.execAsync('PRAGMA foreign_keys = ON;');
  const row = await db.getFirstAsync<{ user_version: number }>('PRAGMA user_version;');
  let version = row?.user_version ?? 0;

  if (version < 1) {
    await db.execAsync(schemaV1);
    version = 1;
  }

  // --- Add future migrations here ---
  // if (version < 2) {
  //   await db.execAsync(schemaV2);
  //   version = 2;
  // }
  //
  // For ALTER TABLE migrations (no IF NOT EXISTS in SQLite):
  // if (version < 3) {
  //   if (!(await hasColumn(db, 'items', 'new_column'))) {
  //     await db.execAsync('ALTER TABLE items ADD COLUMN new_column TEXT;');
  //   }
  //   version = 3;
  // }

  // Always set version unconditionally (not inside an if-block)
  await db.execAsync(`PRAGMA user_version = ${SCHEMA_VERSION};`);

  // Suppress unused warning — remove when first ALTER migration is added
  void hasColumn;
}

// TODO: Replace 'myapp.db' with your app's database name
export async function getDb() {
  if (!dbPromise) {
    dbPromise = (async () => {
      const db = await SQLite.openDatabaseAsync('myapp.db');
      await db.withTransactionAsync(async () => {
        await migrate(db);
      });
      return db;
    })();
  }
  return dbPromise;
}

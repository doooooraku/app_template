/**
 * Example repository — demonstrates the CRUD pattern with expo-sqlite.
 *
 * Copy this file for each entity in your app.
 */
import { getDb } from './db';

// TODO: Replace with your actual model type
export type Item = {
  id: string;
  created_at: string;
  updated_at: string;
  title: string;
  status: string;
};

export async function getAllItems(): Promise<Item[]> {
  const db = await getDb();
  return db.getAllAsync<Item>('SELECT * FROM items ORDER BY updated_at DESC;');
}

export async function getItemById(id: string): Promise<Item | null> {
  const db = await getDb();
  return db.getFirstAsync<Item>('SELECT * FROM items WHERE id = ?;', [id]);
}

export async function insertItem(item: Omit<Item, 'created_at' | 'updated_at'>): Promise<void> {
  const db = await getDb();
  const now = new Date().toISOString();
  await db.runAsync(
    'INSERT INTO items (id, created_at, updated_at, title, status) VALUES (?, ?, ?, ?, ?);',
    [item.id, now, now, item.title, item.status],
  );
}

export async function updateItem(id: string, updates: Partial<Pick<Item, 'title' | 'status'>>) {
  const db = await getDb();
  const now = new Date().toISOString();
  const fields: string[] = ['updated_at = ?'];
  const values: (string | number | null)[] = [now];

  if (updates.title !== undefined) {
    fields.push('title = ?');
    values.push(updates.title);
  }
  if (updates.status !== undefined) {
    fields.push('status = ?');
    values.push(updates.status);
  }

  values.push(id);
  await db.runAsync(`UPDATE items SET ${fields.join(', ')} WHERE id = ?;`, values);
}

export async function deleteItem(id: string): Promise<void> {
  const db = await getDb();
  await db.runAsync('DELETE FROM items WHERE id = ?;', [id]);
}

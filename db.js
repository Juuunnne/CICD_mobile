import { join, dirname } from 'path';
import { LowSync, JSONFileSync } from 'lowdb';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const file = join(__dirname, 'db.json');
const adapter = new JSONFileSync(file);
const db = new LowSync(adapter);

db.read();

db.data ||= { todos: [] };

db.write();

export default db; 
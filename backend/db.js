import { join, dirname } from 'path';
import low from 'lowdb';
import FileSync from 'lowdb/adapters/FileSync.js';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const file = join(__dirname, 'db.json');
const adapter = new FileSync(file);
const db = low(adapter);

db.defaults({ todos: [] }).write();

export default db; 
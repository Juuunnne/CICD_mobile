import dotenv from 'dotenv';
import express from 'express';
import { fileURLToPath } from 'url';
import db from './db.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the CICD Pipeline Demo',
    version: process.env.npm_package_version || '1.0.0'
  });
});

app.get('/api/todos', (req, res) => {
  res.json(db.data.todos);
});

app.post('/api/todos', (req, res) => {
  const { text } = req.body;
  if (!text) return res.status(400).json({ error: 'text is required' });
  const newTodo = { id: Date.now().toString(), text, completed: false };
  db.data.todos.push(newTodo);
  db.write();
  res.status(201).json(newTodo);
});

app.put('/api/todos/:id', (req, res) => {
  const { id } = req.params;
  const { text, completed } = req.body;
  const todo = db.data.todos.find(t => t.id === id);
  if (!todo) return res.status(404).json({ error: 'Not found' });
  if (text !== undefined) todo.text = text;
  if (completed !== undefined) todo.completed = completed;
  db.write();
  res.json(todo);
});

app.delete('/api/todos/:id', (req, res) => {
  const { id } = req.params;
  const initialLength = db.data.todos.length;
  db.data.todos = db.data.todos.filter(t => t.id !== id);
  if (db.data.todos.length === initialLength) return res.status(404).json({ error: 'Not found' });
  db.write();
  res.status(204).end();
});

// Only start the server if this file is run directly
const currentModule = fileURLToPath(import.meta.url);
const isMainModule = process.argv[1] === currentModule;

if (isMainModule) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

export default app; // For testing

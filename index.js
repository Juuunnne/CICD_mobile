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
  res.json(db.get('todos').value());
});

app.post('/api/todos', (req, res) => {
  const { text } = req.body;
  if (!text) return res.status(400).json({ error: 'text is required' });
  const newTodo = { id: Date.now().toString(), text, completed: false };
  db.get('todos').push(newTodo).write();
  res.status(201).json(newTodo);
});

app.put('/api/todos/:id', (req, res) => {
  const { id } = req.params;
  const { text, completed } = req.body;
  const todo = db.get('todos').find({ id }).value();
  if (!todo) return res.status(404).json({ error: 'Not found' });
  if (text !== undefined) todo.text = text;
  if (completed !== undefined) todo.completed = completed;
  db.write();
  res.json(todo);
});

app.delete('/api/todos/:id', (req, res) => {
  const { id } = req.params;
  const exist = db.get('todos').find({ id }).value();
  if (!exist) return res.status(404).json({ error: 'Not found' });
  db.get('todos').remove({ id }).write();
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

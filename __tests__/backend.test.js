import request from 'supertest';
import app from '../index.js';
import db from '../db.js';

describe('Backend API /api/todos', () => {
  beforeEach(() => {
    db.data.todos = [];
    db.write();
  });

  it('creates a todo', async () => {
    const res = await request(app).post('/api/todos').send({ text: 'Test' });
    expect(res.status).toBe(201);
    expect(res.body.text).toBe('Test');
  });

  it('lists todos', async () => {
    await request(app).post('/api/todos').send({ text: 'A' });
    const res = await request(app).get('/api/todos');
    expect(res.body.length).toBe(1);
  });

  it('updates a todo', async () => {
    const { body } = await request(app).post('/api/todos').send({ text: 'B' });
    const res = await request(app).put(`/api/todos/${body.id}`).send({ completed: true });
    expect(res.body.completed).toBe(true);
  });

  it('deletes a todo', async () => {
    const { body } = await request(app).post('/api/todos').send({ text: 'C' });
    const res = await request(app).delete(`/api/todos/${body.id}`);
    expect(res.status).toBe(204);
    const list = await request(app).get('/api/todos');
    expect(list.body.length).toBe(0);
  });
}); 
import request from 'supertest';
import app from '../index.js';

describe('API Tests', () => {
  test('GET / should return welcome message', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty('message');
    expect(response.body.message).toContain('Welcome');
  });
  
  // Make sure all tests complete properly
  afterAll((done) => {
    done();
  });
});

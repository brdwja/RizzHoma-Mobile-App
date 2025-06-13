const request = require('supertest');
const express = require('express');
const app = express();
const PekerjaController = require('../src/controllers/pekerjaController');
const PekerjaModel = require('../src/models/pekerjaModel');

app.use(express.json());

// Routing tiruan untuk test
app.get('/pekerja', PekerjaController.ambilSemuaPekerja);
app.post('/pekerja/email', PekerjaController.ambilPekerjaByEmail);

// Mock model
jest.mock('../src/models/pekerjaModel');

describe('PekerjaController', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('ambilSemuaPekerja', () => {
    it('should return all pekerja', async () => {
      const mockData = [{ id: 1, nama: 'John Doe' }];
      PekerjaModel.ambilSemuaPekerja.mockImplementation(cb => cb(null, mockData));

      const res = await request(app).get('/pekerja');

      expect(res.statusCode).toBe(200);
      expect(res.body.data).toEqual(mockData);
    });

    it('should handle error', async () => {
      PekerjaModel.ambilSemuaPekerja.mockImplementation(cb => cb(new Error('DB Error'), null));

      const res = await request(app).get('/pekerja');

      expect(res.statusCode).toBe(500);
      expect(res.body.message).toBe('DB Error');
    });
  });

  describe('ambilPekerjaByEmail', () => {
    it('should return pekerja by email', async () => {
      const mockData = { id: 1, email: 'test@mail.com' };
      PekerjaModel.ambilPekerjaByEmail.mockImplementation((email, cb) => cb(null, mockData));

      const res = await request(app)
        .post('/pekerja/email')
        .send({ email: 'test@mail.com' });

      expect(res.statusCode).toBe(200);
      expect(res.body.data).toEqual(mockData);
    });

    it('should handle error', async () => {
      PekerjaModel.ambilPekerjaByEmail.mockImplementation((email, cb) => cb(new Error('DB Error'), null));

      const res = await request(app)
        .post('/pekerja/email')
        .send({ email: 'test@mail.com' });

      expect(res.statusCode).toBe(500);
      expect(res.body.message).toBe('DB Error');
    });
  });
});

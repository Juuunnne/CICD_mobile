import dotenv from 'dotenv';
import express from 'express';
import { fileURLToPath } from 'url';

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

// Only start the server if this file is run directly
const currentModule = fileURLToPath(import.meta.url);
const isMainModule = process.argv[1] === currentModule;

if (isMainModule) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

export default app; // For testing

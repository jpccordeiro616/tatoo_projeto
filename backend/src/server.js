require('dotenv').config();
const express = require('express');
const db = require('./db');

const app = express();
app.use(express.json());

app.get('/api/status', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT COUNT(*) AS total FROM servicos');
    res.json({ api: 'ok', banco: 'ok', servicos: rows[0].total });
  } catch (err) {
    res.status(500).json({ api: 'ok', banco: 'erro', detalhe: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API rodando em http://localhost:${PORT}`));

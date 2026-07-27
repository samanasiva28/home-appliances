const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// Fetch all categories
app.get('/api/categories', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM categories');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch products by category slug
app.get('/api/products/:categorySlug', async (req, res) => {
  try {
    const { categorySlug } = req.params;
    const [rows] = await db.query(
      `SELECT p.*, c.name as category_name 
       FROM products p 
       JOIN categories c ON p.category_id = c.category_id 
       WHERE c.slug = ?`,
      [categorySlug]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Record user interaction analytics
app.post('/api/interactions', async (req, res) => {
  try {
    const { productId, actionType } = req.body;
    await db.query(
      'INSERT INTO user_interactions (product_id, action_type) VALUES (?, ?)',
      [productId, actionType || 'view_page']
    );
    res.status(201).json({ message: 'Interaction logged successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Backend server running on port ${PORT}`));

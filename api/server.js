const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const db = mysql.createConnection({
    host: 'localhost',
    user: 'your_username', // Ganti dengan username MySQL Anda
    password: 'your_password', // Ganti dengan password MySQL Anda
    database: 'manaj_keuangan_app',
});

db.connect(err => {
    if (err) throw err;
    console.log('Connected to MySQL database.');
});

app.use(cors());
app.use(bodyParser.json());

// Endpoint untuk menambahkan pengeluaran
app.post('/api/keuangan/pengeluaran', (req, res) => {
    const { expense, cost, category } = req.body.data;
    const query = 'INSERT INTO pengeluaran (expense, cost, category) VALUES (?, ?, ?)';

    db.query(query, [expense, cost, category], (err, results) => {
        if (err) {
            return res.status(500).json({ code: 500, status: false, message: err.message });
        }
        res.json({ code: 200, status: true, data: { id: results.insertId, expense, cost, category } });
    });
});

// Endpoint untuk mendapatkan semua pengeluaran
app.get('/api/keuangan/pengeluaran', (req, res) => {
    db.query('SELECT * FROM pengeluaran', (err, rows) => {
        if (err) {
            return res.status(500).json({ code: 500, status: false, message: err.message });
        }
        res.json({ code: 200, status: true, data: rows });
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

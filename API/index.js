const express = require("express");
const mysql = require("mysql2/promise");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// DB pool
const pool = mysql.createPool({
  host: "52.72.198.145", 
  port: 3306,
  user: "pokeuser",
  password: "pokepass",
  database: "pokemon"
});

// Get all cards
app.get("/cards", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM cards;");
    res.json(rows);
  } catch (err) {
    console.error("Get cards error:", err);
    res.status(500).json({ error: "DB query failed", details: err.message || err.sqlMessage });
  }
});

app.post('/users', async (req, res) => {
  const { user_id, username, email, password } = req.body;

  try {
    await pool.query(
      'INSERT INTO users (user_id, username, email, password_hash) VALUES (?, ?, ?, ?)',
      [user_id, username, email, password]
    );

    res.json({ user_id }); // send the generated user_id back
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create user' });
  }
});



// Add card to user collection
app.post("/addcard", async (req, res) => {
  try {
    const { user_id, card_id, quantity = 1, condition = "Good", is_holo = false, notes = null } = req.body;
    const holoFlag = is_holo ? 1 : 0; 

    console.log("Adding card:", { user_id, card_id, quantity, card_condition: condition, holoFlag, notes });

    const [result] = await pool.query(
      `UPDATE user_cards 
       SET quantity = quantity + ? 
       WHERE user_id = ? AND card_id = ? AND card_condition = ? AND is_holo = ?`,
      [quantity, user_id, card_id, condition, holoFlag]
    );

    console.log("Update result:", result);

    if (result.affectedRows === 0) {
      // Insert new row
      const [insertResult] = await pool.query(
        `INSERT INTO user_cards (user_id, card_id, quantity, card_condition, is_holo, notes)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [user_id, card_id, quantity, condition, holoFlag, notes]
      );
      console.log("Insert result:", insertResult);
    }

    res.json({ message: "Card added to collection" });
  } catch (err) {
    console.error("Add card error:", err);
    res.status(500).json({ 
      error: "Add card failed",
      details: err.message || err.sqlMessage
    });
  }
});

// Login user
app.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({ error: "Username and password are required" });
    }

    const [rows] = await pool.query(
      `SELECT user_id, username, email FROM users 
       WHERE username = ? AND password_hash = ?`,
      [username, password]
    );

    if (rows.length === 0) {
      return res.status(401).json({ error: "Invalid username or password" });
    }

    // Return basic user info (no password)
    res.json({ message: "Login successful", user: rows[0] });
  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ error: "Login failed" });
  }
});




// Get a user’s collection
app.get("/users/:id/cards", async (req, res) => {
  try {
    const userId = req.params.id;

    const [rows] = await pool.query(
      `SELECT uc.user_card_id, uc.quantity, uc.card_condition, uc.is_holo, uc.notes,
              c.card_id, c.name, c.set_name, c.number_in_set, c.rarity, c.type, 
              c.hp, c.release_year, c.image_url
       FROM user_cards uc
       JOIN cards c ON uc.card_id = c.card_id
       WHERE uc.user_id = ?`,
      [userId]
    );

    res.json(rows);
  } catch (err) {
    console.error("Get user collection error:", err);
    res.status(500).json({ error: "Failed to fetch user collection", details: err.message || err.sqlMessage });
  }
});

// Update user card entry
app.put("/usercards/:id", async (req, res) => {
  try {
    const userCardId = req.params.id;
    const { quantity, condition, is_holo, notes } = req.body;
    const holoFlag = is_holo ? 1 : 0;

    await pool.query(
      `UPDATE user_cards 
       SET quantity = ?, card_condition = ?, is_holo = ?, notes = ?
       WHERE user_card_id = ?`,
      [quantity, condition, holoFlag, notes, userCardId]
    );

    res.json({ message: "User card updated" });
  } catch (err) {
    console.error("Update user card error:", err);
    res.status(500).json({ error: "Update failed", details: err.message || err.sqlMessage });
  }
});

// Remove card from user collection (decrement or delete if 0)
app.post("/removecard", async (req, res) => {
  try {
    const { user_id, card_id, quantity = 1, condition = "Good", is_holo = false } = req.body;
    const holoFlag = is_holo ? 1 : 0;

    console.log("Removing card:", { user_id, card_id, quantity, condition, holoFlag });

    // First check if the card exists
    const [rows] = await pool.query(
      `SELECT quantity FROM user_cards 
       WHERE user_id = ? AND card_id = ? AND card_condition = ? AND is_holo = ?`,
      [user_id, card_id, condition, holoFlag]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: "Card not found in collection" });
    }

    const currentQty = rows[0].quantity;

    if (currentQty > quantity) {
      // Just decrement
      await pool.query(
        `UPDATE user_cards 
         SET quantity = quantity - ? 
         WHERE user_id = ? AND card_id = ? AND card_condition = ? AND is_holo = ?`,
        [quantity, user_id, card_id, condition, holoFlag]
      );
    } else {
      // Remove row entirely
      await pool.query(
        `DELETE FROM user_cards 
         WHERE user_id = ? AND card_id = ? AND card_condition = ? AND is_holo = ?`,
        [user_id, card_id, condition, holoFlag]
      );
    }

    res.json({ message: "Card removed from collection" });
  } catch (err) {
    console.error("Remove card error:", err);
    res.status(500).json({ error: "Remove card failed", details: err.message || err.sqlMessage });
  }
});


app.listen(5000, "0.0.0.0", () => {
  console.log("API running on port 5000 🚀");
});

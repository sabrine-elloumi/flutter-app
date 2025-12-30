const db = require("../config/db");
// GET all contacts
exports.getAllContacts = (req, res) => {
  db.query("SELECT * FROM contacts", (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results);
  });
};
// ADD contact
exports.createContact = (req, res) => {
  const contact = req.body;

  db.query("INSERT INTO contacts SET ?", contact, (err, result) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Contact added", id: result.insertId });
  });
};
// UPDATE contact
exports.updateContact = (req, res) => {
  const { id } = req.params;

  db.query(
    "UPDATE contacts SET ? WHERE id = ?",
    [req.body, id],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: "Contact updated" });
    }
  );
};
// DELETE contact
exports.deleteContact = (req, res) => {
  const { id } = req.params;

  db.query("DELETE FROM contacts WHERE id = ?", [id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Contact deleted" });
  });
};


const express = require("express");
const router = express.Router();

const contactController = require("../controllers/contact.controller");

// GET all contacts
router.get("/", contactController.getAllContacts);

// CREATE a new contact
router.post("/", contactController.createContact);

// UPDATE a contact by ID
router.put("/:id", contactController.updateContact);

// DELETE a contact by ID
router.delete("/:id", contactController.deleteContact);

module.exports = router;




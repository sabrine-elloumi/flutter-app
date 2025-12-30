const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const contactRoutes = require("./routes/contact.routes");

const app = express();

app.use(cors());
app.use(bodyParser.json());

app.use("/api/contacts", contactRoutes);

module.exports = app;

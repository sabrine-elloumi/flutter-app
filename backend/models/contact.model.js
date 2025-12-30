class Contact {
  constructor({ id, user_id, name, phone, email, address, whatsapp, photo_path }) {
    this.id = id;
    this.user_id = user_id;
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.address = address;
    this.whatsapp = whatsapp;
    this.photo_path = photo_path;
  }
}

module.exports = Contact;


import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../service/contact_service.dart'; // ✅ chemin corrigé

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  // Charger les contacts d’un utilisateur
  Future<void> loadContacts(int userId) async {
    try {
      _contacts = await ContactService.getContacts(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('LOAD CONTACTS ERROR: $e');
    }
  }

  // Ajouter un contact
  Future<void> addContact(Contact contact) async {
    try {
      await ContactService.addContact(contact);
      await loadContacts(contact.userId);
    } catch (e) {
      debugPrint('ADD CONTACT ERROR: $e');
    }
  }

  // Supprimer un contact
  Future<void> deleteContact(int id, int userId) async {
    try {
      await ContactService.deleteContact(id);
      await loadContacts(userId);
    } catch (e) {
      debugPrint('DELETE CONTACT ERROR: $e');
    }
  }

  // Vider la liste (logout)
  void clearContacts() {
    _contacts = [];
    notifyListeners();
  }
}



import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact.dart';

class ContactService {
  static const String baseUrl = 'http://10.0.2.2:3000/contacts';

  static Future<List<Contact>> getContacts(int userId) async {
    final res = await http.get(Uri.parse('$baseUrl?user_id=$userId'));

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Contact.fromJson(e)).toList();
    }
    throw Exception('Failed to load contacts');
  }

  static Future<void> addContact(Contact contact) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contact.toJson()),
    );

    if (res.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }

  static Future<void> deleteContact(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 200) {
      throw Exception('Failed to delete contact');
    }
  }
}

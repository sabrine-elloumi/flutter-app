import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/auth_service.dart';
import '../providers/contact_provider.dart';
import '../models/contact.dart';
import 'add_edit_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthService>(context, listen: false);
    final provider = Provider.of<ContactProvider>(context, listen: false);

    if (auth.currentUser != null) {
      provider.loadContacts(auth.currentUser!.id);
    }
  }

  Future<void> _openWhatsApp(String number) async {
    final cleanNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
    final url = Uri.parse("https://wa.me/$cleanNumber");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final provider = Provider.of<ContactProvider>(context);

    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        title: const Text("My Contacts"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              provider.clearContacts();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),

      body: provider.contacts.isEmpty
          ? const Center(
              child: Text(
                "No contacts found",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: provider.contacts.length,
              itemBuilder: (context, index) {
                final Contact c = provider.contacts[index];

                return Card(
                  color: Colors.green.shade100,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        c.name.isNotEmpty ? c.name[0].toUpperCase() : "?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    title: Text(
                      c.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(c.phone),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // WhatsApp
                        if (c.whatsapp != null && c.whatsapp!.isNotEmpty)
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.green,
                            ),
                            onPressed: () => _openWhatsApp(c.whatsapp!),
                          ),

                        // Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddEditContactPage(),
                              ),
                            );

                            final user = auth.currentUser;
                            if (user != null) {
                              provider.loadContacts(user.id);
                            }
                          },
                        ),

                        // Delete
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await provider.deleteContact(
                              c.id!,
                              auth.currentUser!.id,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Contact deleted"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditContactPage()),
          );

          final user = auth.currentUser;
          if (user != null) {
            provider.loadContacts(user.id);
          }
        },
      ),
    );
  }
}

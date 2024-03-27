import 'package:flutter/material.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/repository/contacts_repository.dart';
import 'package:phone_book_app/widgets/contact_avatar.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contact_phone),
            SizedBox(
              width: 10.0,
            ),
            Text('Phone Book App'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FutureBuilder(
                future: ContactRepository.getAllContacts(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching contacts: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No contacts found'),
                      );
                    } else if (snapshot.hasData) {
                      List<Contact>? contacts = snapshot.data;
                      return ListView.builder(
                        itemCount: contacts!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ContactAvatar(
                                isDetailPage: false,
                                contacts[index].avatar,
                                contacts[index].name),
                            title: Text(contacts[index].name),
                            subtitle: Text(contacts[index].phone),
                            onTap: () {
                              Navigator.pushNamed(context, '/contact-detail',
                                  arguments: {
                                    'contact': contacts[index],
                                    'action': 'Update',
                                  });
                            },
                          );
                        },
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/contact-detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

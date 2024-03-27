import 'package:phone_book_app/models/contact_model.dart';

class ContactRepository {
  static List<Contact> contacts = [
    Contact(
        id: '1',
        name: 'Alice Johnson',
        phone: '+1234567890',
        avatar: 'https://picsum.photos/200/300'),
    Contact(
        id: '2',
        name: 'Bob Smith',
        phone: '+0987654321',
        avatar: 'https://picsum.photos/200/300'),
    Contact(
        id: '3',
        name: 'Charlie Brown',
        phone: '+1122334455',
        avatar: 'https://picsum.photos/200/300'),
    Contact(
        id: '4',
        name: 'David Williams',
        phone: '+5566778899',
        avatar: 'https://picsum.photos/200/300'),
    Contact(
        id: '5',
        name: 'Eva Green',
        phone: '+2244668800',
        avatar: 'https://picsum.photos/200/300'),
  ];

  // Initialize the contacts list
  static void initializeContacts(List<Map<String, dynamic>> jsonList) {
    contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
  }

  static Future<List<Contact>> getAllContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    return contacts;
  }

  static Contact getContactById(String id) {
    return contacts.firstWhere((contact) => contact.id == id);
  }

  // Add a new contact
  static void addContact(Contact contact) {
    contacts.add(contact);
  }

  // Delete the contact with the given id
  static void deleteContact(String id) {
    contacts.removeWhere((contact) => contact.id == id);
  }

  // Update the contact with the given id
  static void updateContact(Contact contact) {
    final contactIndex =
        contacts.indexWhere((contactVal) => contactVal.id == contact.id);
    if (contactIndex != -1) {
      final updatedContact = Contact(
        id: contact.id,
        name: contact.name,
        phone: contact.phone,
        avatar: contact.avatar,
      );
      contacts[contactIndex] = updatedContact;
    }
  }
}

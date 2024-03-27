import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/repository/contacts_repository.dart';
import 'package:phone_book_app/widgets/contact_avatar.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isEditAction = false;
  String actionText = 'Submit';
  Random random = Random();

  Future<void> _getImage() async {
    // Open the image picker and select an image from the gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  String? validatePhoneNumber(String value) {
    // Regular expression to validate phone number starting with '+' and not exceeding 10 characters
    RegExp regex = RegExp(r'^\+[0-9]{1,10}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number starting with "+" and not exceeding 10 characters.';
    }
    return null;
  }

  int generateUniqueId() {
    // Generate a random unique ID between 1 and 1000 and make sure it doesn't already exist
    int id = 0;

    while (ContactRepository.contacts
        .any((contact) => contact.id == id.toString())) {
      id = random.nextInt(1000);
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      // If the route arguments are not null, set the name, phone, and avatar of the contact
      final Contact contact = args['contact'];
      _nameController.text = contact.name;
      _phoneController.text = contact.phone;
      _imageFile = XFile(contact.avatar);
      setState(() {
        actionText = args['action'];
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$actionText Contact'),
            if (actionText == 'Update')
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  ContactRepository.deleteContact(args!['contact'].id);
                  Navigator.pushNamed(context, '/');
                },
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _getImage,
                  child: const Text('Choose Avatar'),
                ),
                const SizedBox(height: 26.0),
                if (_imageFile != null)
                  ContactAvatar(_imageFile!.path, '', isDetailPage: true),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    final words = value.split(' ');
                    if (words.length != 2) {
                      return 'Name must consist of two words';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => validatePhoneNumber(value!),
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final phone = _phoneController.text;
                      final contact = Contact(
                        id: actionText == 'Update'
                            ? args!['contact'].id
                            : generateUniqueId().toString(),
                        name: name,
                        phone: phone,
                        avatar: _imageFile?.path ?? '',
                      );
                      if (actionText == 'Update') {
                        ContactRepository.updateContact(contact);
                      } else {
                        ContactRepository.addContact(contact);
                      }
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  child: Text(actionText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

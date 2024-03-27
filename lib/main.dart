import 'package:flutter/material.dart';
import 'package:phone_book_app/pages/contact_detail.dart';
import 'package:phone_book_app/pages/contact_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ContactList(),
        '/contact-detail': (context) => const ContactDetail(),
      },
    );
  }
}

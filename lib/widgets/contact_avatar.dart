import 'dart:io';

import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  final String? avatar;
  final String name;
  final bool isDetailPage;

  const ContactAvatar(this.avatar, this.name,
      {super.key, required this.isDetailPage});

  @override
  Widget build(BuildContext context) {
    if (avatar != null) {
      if (avatar!.startsWith('http') || avatar!.startsWith('https')) {
        return CircleAvatar(
          radius: isDetailPage ? 75 : 25,
          backgroundImage: NetworkImage(avatar!),
        );
      } else {
        return Container(
            width: isDetailPage ? 150 : 50,
            height: isDetailPage ? 150 : 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.file(
                File(avatar!),
                fit: BoxFit.cover,
              ),
            ));
      }
    } else {
      String initials =
          name.isNotEmpty ? name.split(' ').map((e) => e[0]).join() : '';
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}

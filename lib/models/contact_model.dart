class Contact {
  final String id;
  final String name;
  final String phone;
  final String avatar;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}

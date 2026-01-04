class Contact {
  final int? id;
  final int userId;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final String? whatsapp;
  final String? photoPath;

  Contact({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.whatsapp,
    this.photoPath,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      whatsapp: json['whatsapp'],
      photoPath: json['photo_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'whatsapp': whatsapp,
      'photo_path': photoPath,
    };
  }
}


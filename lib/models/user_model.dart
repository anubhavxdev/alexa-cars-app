class User {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? profileImage;
  final String? token;

  User({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.profileImage,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      profileImage: json['profile_image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_image': profileImage,
      'token': token,
    };
  }
}

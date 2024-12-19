class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String profilePicture;
  final String phoneNumber;

  User({required this.id, required this.name, required this.email, required this.password, required this.profilePicture, required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      profilePicture: json['profilePicture'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'profilePicture': profilePicture,
    'phoneNumber': phoneNumber,
  };
}
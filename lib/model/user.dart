import './company.dart';

class User {
  String name;
  int id;
  String email;
  String username;
  Company company;

  User(
      {required this.name,
      required this.id,
      required this.email,
      required this.username,
      required this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        company: Company.fromJson(json['company']));
  }
}

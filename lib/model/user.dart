import './company.dart';
import './address.dart';

class User {
  String name;
  int id;
  String email;
  String username;
  String phone;
  Company company;
  Address address;

  User(
      {required this.name,
      required this.id,
      required this.email,
      required this.username,
      required this.phone,
      required this.company,
      required this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        username: json['username'],
        company: Company.fromJson(json['company']),
        address: Address.fromJson(json['address']));
  }
}

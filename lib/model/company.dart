// ignore_for_file: file_names

class Company {
  String name;

  Company({required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name: json['name']);
  }
}

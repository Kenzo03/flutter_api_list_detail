class Address {
  String street;
  String city;
  String zip;

  Address({required this.street, required this.city, required this.zip});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        street: json['street'], city: json['city'], zip: json['zipcode']);
  }
}

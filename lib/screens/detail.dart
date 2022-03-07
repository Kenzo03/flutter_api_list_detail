import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'dart:convert';

Future<User> fetchUser(int id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('User not found!');
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Detail'),
        ),
        body: Center(
            child: FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.username);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                })));
  }
}

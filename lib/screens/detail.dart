import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Model
import '../model/user.dart';

//Component
import '../components/blankslate.dart';

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
                    User user = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.black87,
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/avatar.png'),
                                backgroundColor: Colors.white,
                                radius: 48),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(user.name,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 4),
                              Text('@${user.username}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87))
                            ],
                          ),
                          Text(user.email,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Blankslate();
                  }

                  return const CircularProgressIndicator();
                })));
  }
}

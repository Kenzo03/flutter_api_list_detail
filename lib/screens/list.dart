import 'package:flutter/material.dart';

import 'package:api_list_detail/screens/detail.dart';
import '../model/user.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<User>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load user');
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('User List'),
            ),
            body: Center(
                child: FutureBuilder<List<User>>(
                    future: futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<User> user = snapshot.data!;
                        return ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.asset('images/avatar.png'),
                                title: Text('Name: ${user[index].name}'),
                                subtitle: Text(
                                    'Company : ${user[index].company.name}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(id: user[index].id)),
                                  );
                                },
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }))));
  }
}

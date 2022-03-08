import 'package:flutter/material.dart';

//Screen
import './detail.dart';

//Model
import '../model/user.dart';

//Component
import '../components/blankslate.dart';
import '../components/custom_circle_avatar.dart';

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

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

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
                    future: fetchUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<User> user = snapshot.data!;
                        return ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: BorderedCircleAvatar(
                                  borderColor: Colors.grey.shade700,
                                  imgPath: 'images/avatar.png',
                                  borderWidth: 2,
                                  rad: 20,
                                ),
                                title: Text(user[index].name),
                                subtitle: Text(user[index].email),
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
                        return const Blankslate();
                      }
                      return const CircularProgressIndicator();
                    }))));
  }
}

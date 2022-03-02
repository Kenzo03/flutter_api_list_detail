import 'package:flutter/material.dart';
import 'package:api_list_detail/screens/list.dart';
import 'package:api_list_detail/screens/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API List Detail',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ListScreen(),
        '/detail': (context) => const DetailScreen(id: 0),
      },
    );
  }
}

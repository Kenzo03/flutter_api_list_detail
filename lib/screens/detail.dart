import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Model
import '../model/user.dart';

//Component
import '../components/blankslate.dart';
import '../components/custom_circle_avatar.dart';

Future<User> fetchUser(int id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('User not found!');
  }
}

class DetailScreen extends StatelessWidget {
  final int id;

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Detail'),
          actions: const <Widget>[FavoriteButton()],
        ),
        body: Center(
            child: FutureBuilder<User>(
                future: fetchUser(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User user = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CustomCard(user: user),
                          ),
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

class CustomCard extends StatelessWidget {
  final User user;

  const CustomCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        children: <Widget>[
          Card(
            child: SizedBox(
              height: 330.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Text('@${user.username}',
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.mail_outline,
                              color: Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(user.email,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.house_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                  user.address.street +
                                      ', ' +
                                      user.address.city +
                                      ', ' +
                                      user.address.zip,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.phone_callback_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(user.phone,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.domain,
                              color: Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(user.company.name,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          FractionalTranslation(
            translation: const Offset(0.0, -0.4),
            child: Align(
              child: BorderedCircleAvatar(
                borderColor: Colors.grey.shade700,
                imgPath: 'images/avatar.png',
                borderWidth: 4,
                rad: 54,
              ),
              alignment: const FractionalOffset(0.5, 0.0),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isFavorite ? Icons.star : Icons.star_border,
            color: Colors.yellow),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
            SnackBar snackBar = SnackBar(
                content: Text(isFavorite
                    ? 'Added to Favorite'
                    : 'Removed from Favorite'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}

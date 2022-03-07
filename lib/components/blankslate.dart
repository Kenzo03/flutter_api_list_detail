import 'package:flutter/material.dart';

class Blankslate extends StatelessWidget {
  const Blankslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.feedback_outlined, color: Colors.grey, size: 64),
        SizedBox(height: 24),
        Text('Something went wrong, please try again later.',
            style: TextStyle(color: Colors.grey))
      ],
    );
  }
}

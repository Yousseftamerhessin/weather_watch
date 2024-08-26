import 'package:flutter/material.dart';

class RateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.rate_review_outlined),
      title: const Text('Rate App'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

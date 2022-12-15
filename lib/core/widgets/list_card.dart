import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const ListCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        subtitle: Text(subtitle),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

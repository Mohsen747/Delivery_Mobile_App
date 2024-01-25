// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PlantDetailsScreen extends StatelessWidget {
  final dynamic plant;

  const PlantDetailsScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant['name'])),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${plant['name']}'),
            Text('Details: ${plant['details']}'),
          ],
        ),
      ),
    );
  }
}

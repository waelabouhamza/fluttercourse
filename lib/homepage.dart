// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Install'),
          actions: [],
        ),
        body: ListView(
          children: [
            // Text("How Are You", style: )
          ],
        ));
  }
}

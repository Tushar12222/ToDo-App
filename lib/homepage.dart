import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:loginapp/profile.dart';
import 'package:loginapp/signout.dart';
import 'package:loginapp/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _currentscreen = 0;
  final screens = [
    Profile(),
    ToDo(),
    SignOut(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) {
            setState(() {
              _currentscreen = index;
            });
          },
          items: [
            Icon(Icons.person),
            Icon(Icons.list_rounded),
            Icon(
              Icons.power_settings_new_outlined,
              color: Colors.red,
            ),
          ],
        ),
        body: screens[_currentscreen],
      ),
    );
  }
}

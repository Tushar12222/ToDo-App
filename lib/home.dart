import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/authenticate.dart';
import 'package:loginapp/homepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) 
          {
            if(snapshot.hasData)
            {
              return HomePage();
            }
            else
            {
              return Authenticate();
            }
          },
        ),
      ),
    );
  }
}

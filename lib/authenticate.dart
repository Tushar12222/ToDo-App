import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/signuppage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  
  @override
  State<Authenticate> createState() => _AuthenticateState();

  
}

class _AuthenticateState extends State<Authenticate> {
  //text controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var error = "";
  bool isLoading = false;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
    } catch (e) {
      error = e.toString();
      if (error.contains('password is invalid')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 500),
            content: Text('Invalid Password! Please try again.'),
          ),
        );
      }

      if (error.contains('user record')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1000),
            content: Text(
                'User not registered! Please sign up and then try logging in.'),
          ),
        );
      }

      if (!error.contains('user record') &&
          !error.contains('password is invalid')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1000),
            content: Text(
                'Request blocked due to too many attempts! Please try again later.'),
          ),
        );
      }
    }
  }

  bool validateEmail() {
    final bool isValid = EmailValidator.validate(_email.text.trim());
    return isValid;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ToDo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),

                  //Icon
                  Icon(Icons.android, color: Colors.green, size: 70),

                  //Welcome text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),

                  //separation
                  Text(
                    '________________________________',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),

                  SizedBox(height: 30),
                  //email
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  //password
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      ),
                      validator: (password) {},
                    ),
                  ),

                  SizedBox(height: 10),
                  //Sign in button
                  Container(
                    width: 300,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final form = formKey.currentState!;
                        if (validateEmail()) {
                          setState(() {
                            isLoading = true;
                          });
                          await signIn();
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 500),
                              content: Text('Invalid Email'),
                            ),
                          );
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  //sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 100),
                      Text(
                        'Not Registered?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 145, 81, 21),
                        ),
                      ),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            SignupPage(),
                            transition: Transition.downToUp,
                          );
                        },
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

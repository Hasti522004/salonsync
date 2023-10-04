import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up', // Replace with your desired title
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email ID",
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                    border: UnderlineInputBorder(),
                  ),
                ),
                TextField(
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                      border: UnderlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            passwordVisible = !passwordVisible;
                            setState(() {});
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  minWidth: 200.0,
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  minWidth: 200.0,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/google_logo.png'),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                      ),
                      SizedBox(width: 10),
                      Text("Sign In with Google"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
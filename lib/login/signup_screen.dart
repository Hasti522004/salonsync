import 'package:flutter/material.dart';

class Signup_Screen extends StatelessWidget {
  const Signup_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Name', // Replace with your desired title
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'E-mail', // Replace with your desired title
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "email",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Number', // Replace with your desired title
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Number",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Password', // Replace with your desired title
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Color.fromARGB(255, 129, 129, 129),
            elevation: 10,
            minWidth: 200.0,
            onPressed: () {},
            child: Text(
              'Sign Up',
              style: TextStyle(color: Color.fromRGBO(14, 11, 11, 1)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Color.fromARGB(255, 129, 129, 129),
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
                          image: AssetImage('assets/images/google_logo.png'),
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
    ));
  }
}

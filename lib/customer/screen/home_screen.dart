import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Salon-List"),
        leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 78, 75, 75),
        // elevation: 10.0,// for shadow effect
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child: Card(
                      color: Color.fromARGB(57, 123, 120, 121),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text('Hello'),
                              color: Color.fromARGB(255, 72, 72, 70),
                              height: 200,
                              width: 200,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Bonanza",
                                style: TextStyle(
                                    fontSize: 70, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Kalavad Road, Rajkot',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Column(
                                children: [],
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

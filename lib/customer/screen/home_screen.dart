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
                  height: MediaQuery.of(context).size.height *
                      0.25, //change height = 200
                  child: Card(
                      color: Color.fromARGB(57, 123, 120, 121),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 175,
                              width: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/first.jpg'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bonanza",
                                  style: TextStyle(
                                      fontSize: 65,
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Kalavad Road, Rajkot',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .star, // You can customize this icon as needed
                                      color: Colors
                                          .yellow, // Customize the star color
                                      size: 24, // Customize the star size
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_half,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    SizedBox(
                                        width:
                                            18), // Add some spacing between the star and the like button
                                    Icon(
                                      Icons
                                          .favorite_border, // Customize this icon as needed
                                      color: Color.fromARGB(255, 12, 8,
                                          8), // Customize the like button color
                                      size:
                                          24, // Customize the like button size
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

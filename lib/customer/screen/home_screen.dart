import 'package:flutter/material.dart';
import 'package:salonsync/customer/model/salon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = [];
    for (int i = 0; i < 20; i++) {
      SalonCard card = SalonCard(
        image: 'assets/images/first.jpg',
        salonName: 'Salon $i',
        address: 'Address $i',
        rating: 4.5,
        likeCount: 10,
      );
      cardWidgets.add(card.buildCardWidget(context));
    }
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
              children: cardWidgets,
            ),
          )
        ],
      ),
    ));
  }
}

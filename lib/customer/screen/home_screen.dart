import 'package:flutter/material.dart';
import 'package:salonsync/customer/model/card_model.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = [];
    for (int i = 0; i < 20; i++) {
      CardModel card = CardModel(
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

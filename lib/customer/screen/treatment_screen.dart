import 'package:flutter/material.dart';
import 'package:salonsync/customer/model/treatment_card.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = [];
    for (int i = 0; i < 20; i++) {
      TreatmentCard card = TreatmentCard(
        image: 'assets/images/treatment-2.jpeg',
        treatmentName: 'Treatment $i',
        details: 'Details $i',
        price: 100,
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

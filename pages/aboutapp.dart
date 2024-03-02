// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(204, 233, 30, 98),
          title: Text(
            "About App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(127, 255, 157, 190),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  //color: Colors.pink,
                  child: Text(
                    "This application is an online store aimed at enabling the user to browse products and then purchase them or add them to the cart for later purchase. It also provides many advantages inside it.\n\nThis application is a semester project for fourth-year students created by:\n\n- Ibrahem Shaddoud\n- Issa Ahmed\n- Mohammed Ahmed\n\nWe hope that you will like this application.",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import '../compount/mydrwer.dart';
import '../compount/productview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../compount/search.dart';

class Tvs extends StatefulWidget {
  @override
  State<Tvs> createState() => _TvsState();
}

class _TvsState extends State<Tvs> {
  var listsearch = [];
  Future getData() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/productslist.php');
    var data = {"cat": "4"};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['productname']);
    }
    return (responsebody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black, size: 27, opacity: 7),
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontStyle: FontStyle.italic,
                shadows: const <Shadow>[
                  Shadow(
                    color: Colors.black,
                  )
                ]),
            title: Text(
              "Smart TVs",
              style: TextStyle(fontFamily: "Bold Italic Art"),
            ),
            titleSpacing: 20,
            backgroundColor: Color.fromARGB(204, 233, 30, 98),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: Search(listt: listsearch));
                },
                splashRadius: 2,
              )
            ]),
        drawer: MyDrawer(),
        body: Container(
            color: Color.fromARGB(127, 255, 157, 190),
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Productlist(
                          id: snapshot.data[i]['productid'],
                          name: snapshot.data[i]['productname'].toString(),
                          company: snapshot.data[i]['company'].toString(),
                          date: snapshot.data[i]['datofpublication'].toString(),
                          price: snapshot.data[i]['offerpersent'] == 0
                              ? snapshot.data[i]['price'].toString()
                              : (snapshot.data[i]['price'] *
                                      ((100 -
                                              snapshot.data[0]
                                                  ['offerpersent']) /
                                          100))
                                  .toStringAsFixed(1),
                          cat: snapshot.data[i]['catid'],
                          pimage: snapshot.data[i]['image'].toString(),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )));
  }
}

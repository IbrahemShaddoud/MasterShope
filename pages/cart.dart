// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mastershop/compount/cartitem.dart';
import 'package:mastershop/pages/checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../compount/mydrwer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String id = "";
  var productsids = [];
  var productscount = [];

  double price = 0.0;

  Future getid() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getid.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      "useremail": preferences.getString("email"),
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    id = responsebody[0]['userid'].toString();

    return getData();
  }

  Future getData() async {
    var listt = [];
    var countlist = [];
    double p = 0;
    var url = Uri.parse('http://10.0.2.2/mastershop/cart.php');
    var data = {"userid": this.id.toString()};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listt.add(responsebody[i]['productid']);
      countlist.add(responsebody[i]['count']);
      p = p + (responsebody[i]['price'] * responsebody[i]['count']);
    }

    setState(() {
      price = p;
      productsids = listt;
      productscount = countlist;
    });

    return responsebody;
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
            "My Cart",
            style: TextStyle(fontFamily: "Bold Italic Art"),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromARGB(204, 233, 30, 98),
        ),
        drawer: MyDrawer(),
        body: Container(
            color: Color.fromARGB(127, 255, 157, 190),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: FutureBuilder(
                            future: getid(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length + 1,
                                    itemBuilder: (context, i) {
                                      if (i < snapshot.data.length) {
                                        CartItem item = new CartItem(
                                          count: int.parse(snapshot.data[i]
                                                  ['count']
                                              .toString()),
                                          id: snapshot.data[i]['productid']
                                              .toString(),
                                        );

                                        return item;
                                      } else {
                                        return SizedBox(
                                          height: 260,
                                        );
                                      }
                                    });
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 185,
                        color: Color.fromARGB(199, 255, 157, 190),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Price ',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  price.toString(),
                                  //calculate_price().toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 112, 107, 107),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' S.P',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Shipping ',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  '5',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 112, 107, 107),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' S.P',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Divider(
                              color: Color.fromARGB(255, 112, 107, 107),
                              thickness: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total Price',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  (price + 5).toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 112, 107, 107),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' S.P',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                                color: Color.fromARGB(204, 233, 30, 98),
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Checkout(
                                      productid: productsids,
                                      productcount: productscount,
                                      price: price,
                                      fromCart: true,
                                    );
                                  }));
                                },
                                child: Text(
                                  "Make order",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}

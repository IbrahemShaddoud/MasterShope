import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mastershop/pages/cart.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  var count;
  var id;
  CartItem({this.count, this.id});

  @override
  State<CartItem> createState() =>
      _CartItemState(count: this.count, id: this.id);
}

class _CartItemState extends State<CartItem> {
  var count;
  var id;
  _CartItemState({this.count, this.id});
  String userid = "";

  Future getData() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/cartitem.php');
    var data = {"productid": this.id.toString()};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return (responsebody);
  }

  void initState() {
    getid();
    super.initState();
  }

  Future getid() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getid.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      "useremail": preferences.getString("email"),
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    userid = responsebody[0]['userid'].toString();
  }

  removFromCart() async {
    var data = {
      "userid": userid.toString(),
      "productid": id.toString(),
    };
    var url = Uri.parse('http://10.0.2.2/mastershop/removfromcart.php');
    await http.post(url, body: data);
  }

  changCount() async {
    var data = {
      "userid": userid.toString(),
      "productid": id.toString(),
      "newcount": count.toString()
    };
    var url = Uri.parse('http://10.0.2.2/mastershop/changcount.php');
    await http.post(url, body: data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 180,
              child: Card(
                margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.network(
                                'http://10.0.2.2/mastershop/mastershopproduct/${snapshot.data[0]['image'].toString()}',
                                fit: BoxFit.fitWidth),
                          )),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              top: 6,
                              right: 10,
                            ),
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data[0]['productname'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color:
                                            Color.fromARGB(204, 233, 30, 98)),
                                  ),
                                ),
                                Divider(
                                  color: Color.fromARGB(127, 255, 157, 190),
                                  indent: 0,
                                  endIndent: 100,
                                  thickness: 3,
                                ),
                                Container(
                                  child: Text(
                                    snapshot.data[0]['company'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 23),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: RichText(
                                              text: TextSpan(children: [
                                        TextSpan(
                                          text: snapshot.data[0]
                                                      ['offerpersent'] ==
                                                  0
                                              ? snapshot.data[0]['price']
                                                  .toString()
                                              : (snapshot.data[0]['price'] *
                                                      ((100 -
                                                              snapshot.data[0][
                                                                  'offerpersent']) /
                                                          100))
                                                  .toStringAsFixed(1),
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 23),
                                        ),
                                      ]))),
                                      Expanded(
                                        child: Text(
                                          ' S.P',
                                          style: TextStyle(fontSize: 23),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                      Row(children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (count != 0) {
                                                count = count - 1;
                                                changCount();
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return Cart();
                                                }));
                                              }
                                            });
                                          },
                                          icon: Icon(Icons.remove),
                                          color: Color.fromARGB(
                                              255, 255, 157, 190),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color.fromARGB(
                                                  127, 255, 157, 190),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "$count",
                                                style: TextStyle(),
                                              ),
                                            )),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              count = count + 1;
                                              changCount();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Cart();
                                              }));
                                            });
                                          },
                                          icon: Icon(Icons.add),
                                          color: Color.fromARGB(
                                              255, 255, 157, 190),
                                        ),
                                      ]),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            removFromCart();
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Cart();
                                            }));
                                          },
                                          icon: Icon(Icons
                                              .remove_shopping_cart_outlined),
                                          color: Colors.red),
                                    ])),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center();
          }
        });
  }
}

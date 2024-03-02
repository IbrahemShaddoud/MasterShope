// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/details/headphonedetails.dart';
import '../pages/details/laptopdetails.dart';
import '../pages/details/phonedetails.dart';
import '../pages/details/tabletdetails.dart';
import '../pages/details/tvdetails.dart';
import '../pages/details/watchdetails.dart';

class Productlist extends StatefulWidget {
  final id;
  final name;
  final company;
  final date;
  final price;
  final cat;
  final pimage;
  Productlist(
      {this.id,
      this.name,
      this.company,
      this.date,
      this.price,
      this.cat,
      this.pimage});
  @override
  State<Productlist> createState() => _ProductlistState(
      id: this.id,
      name: this.name,
      company: this.company,
      date: this.date,
      price: this.price,
      cat: this.cat,
      pimage: this.pimage);
}

class _ProductlistState extends State<Productlist> {
  final id;
  final name;
  final company;
  final date;
  final price;
  final cat;
  final pimage;
  _ProductlistState(
      {this.id,
      this.name,
      this.company,
      this.date,
      this.price,
      this.cat,
      this.pimage});

  String i = "";
  Future getid() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getid.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      "useremail": preferences.getString("email"),
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    i = responsebody[0]['userid'].toString();
    addToCart();
  }

  addToCart() async {
    var data = {
      "userid": i,
      "productid": this.id.toString(),
      "price": this.price.toString(),
    };
    var url = Uri.parse('http://10.0.2.2/mastershop/addtocart.php');
    await http.post(url, body: data);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                height: 15, width: 15, child: Center(child: Text("done"))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 250,
        child: Card(
          margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
          child: Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: Image.network(
                                'http://10.0.2.2/mastershop/mastershopproduct/${pimage}',
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Text(
                              'click for mor details',
                              overflow: TextOverflow.clip,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: 10, top: 13, right: 10, bottom: 7),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(127, 255, 157, 190),
                            indent: 0,
                            endIndent: 100,
                            thickness: 3,
                          ),
                          Container(
                            child: Expanded(
                              child: Text(
                                company,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: Text(
                                date,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 85, 84, 84),
                                    fontSize: 23),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: RichText(
                                        text: TextSpan(children: [
                                  TextSpan(
                                    text: price,
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
                          Divider(
                            color: Colors.white,
                            indent: 0,
                            endIndent: 100,
                            thickness: 3,
                          ),
                          Container(
                              height: 25,
                              margin: EdgeInsets.only(
                                  left: 0, top: 0, right: 0, bottom: 3),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          getid();
                                        },
                                        icon:
                                            Icon(Icons.shopping_cart_outlined),
                                        color: Colors.red),
                                  ])),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (cat == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Lapdetails(id: this.id);
          }));
        }
        if (cat == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Phonedetails(id: this.id);
          }));
        }
        if (cat == 3) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Tabletdetails(id: this.id);
          }));
        }
        if (cat == 4) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Tvdetails(id: this.id);
          }));
        }
        if (cat == 5) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Watchdetails(id: this.id);
          }));
        }
        if (cat == 6) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Headphonedetails(id: this.id);
          }));
        }
      },
    );
  }
}

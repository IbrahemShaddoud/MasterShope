// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Checkout extends StatefulWidget {
  final price;
  List productid;
  List productcount;
  bool fromCart;
  Checkout(
      {this.price,
      required this.productid,
      required this.productcount,
      required this.fromCart});

  @override
  State<Checkout> createState() => _CheckoutState(
      price: this.price,
      productid: this.productid,
      productcount: this.productcount,
      fromCart: this.fromCart);
}

class _CheckoutState extends State<Checkout> {
  final price;
  List productid;
  List productcount;
  bool fromCart;
  _CheckoutState(
      {this.price,
      required this.productid,
      required this.productcount,
      required this.fromCart});

  TextEditingController name = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController address = new TextEditingController();
  GlobalKey<FormState> info = new GlobalKey<FormState>();

  bool active1 = false;
  bool active2 = false;
  bool active3 = false;
  bool active4 = false;
  bool active5 = false;
  bool active6 = false;

  String id = "";
  String orderid = "";

  Future getid() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getid.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      "useremail": preferences.getString("email"),
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    id = responsebody[0]['userid'].toString();
    getordernumber();
  }

  void initState() {
    getid();
    super.initState();
  }

  emptyCart() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/emptycart.php');
    var data = {"userid": id.toString()};
    var response = await http.post(url, body: data);
    jsonDecode(response.body);
  }

  showdialogall(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                Text("loading   "),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  showdialog(context, String mytitle, String myconten) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(mytitle),
            content: Text(myconten),
            actions: [
              TextButton(
                child: Text(
                  "contine shopping",
                  style: TextStyle(
                      color: Color.fromARGB(204, 233, 30, 98), fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  getordernumber() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getorder.php');
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    orderid =
        (int.parse(responsebody[0]["max(order_id)"].toString()) + 1).toString();
  }

  order(String pro, String co) async {
    if (info.currentState!.validate()) {
      info.currentState!.save();

      showdialogall(context);

      var data = {
        "clintid": id,
        "orderid": orderid,
        "productid": pro,
        "productcount": co,
        "legalname": name.text,
        "number": number.text,
        "price": this.price.toString(),
        "address": address.text,
      };

      var url = Uri.parse('http://10.0.2.2/mastershop/order.php');
      await http.post(url, body: data);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showdialog(context, "Done", "your order is complete");
      setState(() {
        active6 = !active6;
      });
      if (fromCart) {
        emptyCart();
      }
    }
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
          "Check out",
          style: TextStyle(fontFamily: "Bold Italic Art"),
        ),
        titleSpacing: 20,
        backgroundColor: Color.fromARGB(204, 233, 30, 98),
      ),
      bottomNavigationBar: active6
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.white,
                  onPressed: () {}))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  onPressed: () {
                    for (int i = 0; i < productid.length; i++) {
                      order(
                          productid[i].toString(), productcount[i].toString());
                    }
                  },
                  child: Text(
                    "check out",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Personal Information",
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Form(
              key: info,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "can't be embty";
                      }
                      return null;
                    },
                    cursorHeight: 30,
                    cursorColor: Color.fromARGB(255, 235, 101, 101),
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Enter legal Name",
                      labelStyle: TextStyle(color: Colors.pink, fontSize: 15),
                      filled: true,
                      hintText: "name",
                      hintStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 235, 101, 101),
                          )),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromARGB(0, 255, 157, 190),
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: number,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "can't be embty";
                      }
                      return null;
                    },
                    cursorHeight: 30,
                    cursorColor: Color.fromARGB(255, 235, 101, 101),
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Enter Number",
                      labelStyle: TextStyle(color: Colors.pink, fontSize: 15),
                      filled: true,
                      hintText: "phone number",
                      hintStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 235, 101, 101),
                          )),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromARGB(0, 255, 157, 190),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "The payment value is ",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: price.toStringAsFixed(1),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: " S.P without shipping costs.",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Text(
              "Choose Delivery Type",
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      active1 = !active1;
                      active2 = false;
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: active1
                              ? Colors.pink
                              : Color.fromARGB(255, 204, 199, 199)),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            "images/chck_out/delivery.jpg",
                            width: 60,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Delivery",
                            style: TextStyle(
                              color: active1 ? Colors.pink : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      active2 = !active2;
                      active1 = false;
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: active2
                              ? Colors.pink
                              : Color.fromARGB(255, 204, 199, 199)),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.asset("images/chck_out/revice.jpg"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Recive",
                            style: TextStyle(
                              color: active2 ? Colors.pink : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            active1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          "shipping address",
                          style: TextStyle(
                              color: Color.fromARGB(204, 233, 30, 98),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: address,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "can't be embty";
                            }
                            return null;
                          },
                          cursorHeight: 30,
                          cursorColor: Color.fromARGB(255, 235, 101, 101),
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "Enter Address",
                            labelStyle:
                                TextStyle(color: Colors.pink, fontSize: 15),
                            filled: true,
                            hintText: "Add your address :",
                            hintStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 235, 101, 101),
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(0, 255, 157, 190),
                                )),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("Is that your :"),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 30,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    active3 = !active3;
                                    active4 = false;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Home",
                                      style: TextStyle(
                                          color: active3
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: active3
                                          ? Colors.pink
                                          : Color.fromARGB(204, 240, 159, 186),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 30,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    active4 = !active4;
                                    active3 = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "Company",
                                      style: TextStyle(
                                          color: active4
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: active4
                                          ? Colors.pink
                                          : Color.fromARGB(204, 240, 159, 186),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ])
                : SizedBox(
                    width: 2,
                  ),
            active2
                ? Text("We are waiting you to receive your order.",
                    style: TextStyle(
                        color: Color.fromARGB(204, 233, 30, 98),
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
                : SizedBox(
                    width: 2,
                  ),
            SizedBox(height: 20),
            Divider(
              color: Color.fromARGB(204, 233, 30, 98),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Your order needs ",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: 24.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: " hours to be able to receive!!",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

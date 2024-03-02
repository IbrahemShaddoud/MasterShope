import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../compount/mydrwer.dart';
import 'package:mastershop/pages/checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tabletdetails extends StatefulWidget {
  final id;
  Tabletdetails({this.id});

  @override
  State<Tabletdetails> createState() => _TabletdetailsState(i: this.id);
}

class _TabletdetailsState extends State<Tabletdetails> {
  final i;
  _TabletdetailsState({this.i});

  Future getData() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/tabletdetails.php');
    var data = {"id": i.toString()};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  String id = "";
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
    id = responsebody[0]['userid'].toString();
  }

  addToCart(String price) async {
    var data = {
      "userid": id,
      "productid": i.toString(),
      "price": price.toString(),
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
            "Details",
            style: TextStyle(fontFamily: "Bold Italic Art"),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromARGB(204, 233, 30, 98),
          actions: [
            IconButton(
              icon: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Icon(Icons.arrow_back)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              splashRadius: 2,
            )
          ]),
      drawer: MyDrawer(),
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    child: GridTile(
                      child: Stack(
                        children: [
                          Center(
                            child: Image.network(
                                'http://10.0.2.2/mastershop/mastershopproduct/${snapshot.data[0]['image'].toString()}',
                                fit: BoxFit.fill),
                          ),
                          Positioned(
                              height: 120,
                              width: 90,
                              child: Transform.translate(
                                offset: Offset(
                                    MediaQuery.of(context).size.width / 1.3, 0),
                                child: snapshot.data[0]['offerpersent'] != 0
                                    ? Stack(
                                        children: [
                                          Image.asset(
                                              "images/offers/stecar.png",
                                              fit: BoxFit.contain),
                                          Positioned(
                                            child: Transform.translate(
                                              offset: Offset(24, 36),
                                              child: Transform.rotate(
                                                angle: -0.4,
                                                child: Text(
                                                  "${snapshot.data[0]['offerpersent']}\n % \noff",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              )),
                        ],
                      ),
                      footer: Container(
                          height: 70,
                          color: Colors.black54,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "${snapshot.data[0]['company'].toString()}  ${snapshot.data[0]['productname'].toString()}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: snapshot.data[0]['offerpersent'] == 0
                                    ? Text(
                                        "${snapshot.data[0]['price'].toString()} S.P",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    : Column(children: [
                                        Text(
                                          "${snapshot.data[0]['price'].toString()} S.P",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        Text(
                                          "${(snapshot.data[0]['price'] * ((100 - snapshot.data[0]['offerpersent']) / 100)).toStringAsFixed(1)} S.P",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      ]),
                              ),
                            ],
                          )),
                    ),
                  ),
                  // end header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                size: 35,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                addToCart(snapshot.data[0]['offerpersent'] == 0
                                    ? snapshot.data[0]['price'].toString()
                                    : (snapshot.data[0]['price'] *
                                            ((100 -
                                                    snapshot.data[0]
                                                        ['offerpersent']) /
                                                100))
                                        .toString());
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /* IconButton(
                              icon: Icon(
                                Icons.comment,
                                color: Colors.black54,
                                size: 35,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 10,
                            ), */
                            IconButton(
                                icon: Icon(
                                  Icons.attach_money,
                                  color: Colors.black54,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Checkout(
                                      productid: [this.i],
                                      productcount: ["1"],
                                      price: snapshot.data[0]['offerpersent'] ==
                                              0
                                          ? snapshot.data[0]['price']
                                          : (snapshot.data[0]['price'] *
                                              ((100 -
                                                      snapshot.data[0]
                                                          ['offerpersent']) /
                                                  100)),
                                      fromCart: false,
                                    );
                                  }));
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  //start specifications
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Specifications",
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Model : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['productname']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                204, 233, 30, 98),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Screen : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['screen']
                                              .toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ram : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "${snapshot.data[0]['ram']} GB"
                                              .toString(),
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  204, 233, 30, 98)))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Memory : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['memory']
                                              .toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Camera : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['camera']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                204, 233, 30, 98),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Selfie : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['selfie']
                                              .toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Battery : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['battery']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                204, 233, 30, 98),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("CPU : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['cpu']
                                              .toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("GPU : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['gpu']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                204, 233, 30, 98),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("OS : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              snapshot.data[0]['os'].toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 241, 206, 218),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sound : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['sound']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                204, 233, 30, 98),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(204, 233, 30, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Color : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[0]['colors']
                                              .toString(),
                                          style: TextStyle(color: Colors.white))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // end specifications
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

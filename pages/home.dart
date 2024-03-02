//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mastershop/pages/cart.dart';
import 'package:mastershop/pages/details/headphonedetails.dart';
import 'package:mastershop/pages/details/laptopdetails.dart';
import 'package:mastershop/pages/details/phonedetails.dart';
import 'package:mastershop/pages/details/tabletdetails.dart';
import 'package:mastershop/pages/details/tvdetails.dart';
import 'package:mastershop/pages/details/watchdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../compount/mydrwer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../compount/rate.dart';

import '../compount/search.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}
//هاذا التابع يظهر التقييم

showdialog(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var showrate = preferences.getInt('showrate');
  var showrate1 = preferences.getInt('showrate');
  if (showrate != 0) {
    preferences.setInt('showrate', showrate1! + 1);
  }
  if (showrate == 7)
    return showDialog(
        context: context,
        builder: (context) {
          return Rat();
        });
}

class HomeState extends State<Home> {
  var listsearch = [];

  getpreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString("firstname");
    preferences.getString("lastname");
    preferences.getString("email");
    preferences.getInt('showrate');
  }

  Future getData() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/search.php');
    var response = await http.get(url);
    showdialog(context);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['productname']);
    }
    print(listsearch);
  }

  Future getOffer() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/offer.php');
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getNew() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/new.php');
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  void initState() {
    getData();
    super.initState();
  }

  godetails(int id, int cat) {
    if (cat == 1) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Lapdetails(id: id);
      }));
    }
    if (cat == 2) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Phonedetails(id: id);
      }));
    }
    if (cat == 3) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Tabletdetails(id: id);
      }));
    }
    if (cat == 4) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Tvdetails(id: id);
      }));
    }
    if (cat == 5) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Watchdetails(id: id);
      }));
    }
    if (cat == 6) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Headphonedetails(id: id);
      }));
    }
  }

  List<Container> buildCarouselItems(List data) {
    return data.map((item) {
      return Container(
          color: Colors.white,
          child: InkWell(
            child: GridTile(
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                          'http://10.0.2.2/mastershop/mastershopproduct/${item['image'].toString()}',
                          fit: BoxFit.contain),
                    ),
                    Positioned(
                        height: 120,
                        width: 90,
                        child: Transform.translate(
                          offset: Offset(
                              MediaQuery.of(context).size.width / 1.8, 0),
                          child: Container(
                            child: Stack(
                              children: [
                                Image.asset("images/offers/stecar.png",
                                    fit: BoxFit.contain),
                                Positioned(
                                  child: Transform.translate(
                                    offset: Offset(24, 36),
                                    child: Transform.rotate(
                                      angle: -0.4,
                                      child: Text(
                                        "${item['offerpersent']}\n % \noff",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                footer: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  padding:
                      EdgeInsets.only(left: 0, top: 9, right: 0, bottom: 0),
                  color: Color.fromARGB(136, 0, 0, 0),
                  height: 30,
                  child: Text(
                    item['productname'],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                )),
            onTap: () {
              godetails(
                item['productid'],
                item['catid'],
              );
            },
          ));
    }).toList();
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
              "MasterShop",
              style: TextStyle(fontFamily: "Bold Italic Art"),
            ),
            titleSpacing: 20,
            backgroundColor: Color.fromARGB(204, 233, 30, 98),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Cart();
                    }));
                  })
            ]),
        drawer: MyDrawer(),
        body: Container(
          color: Color.fromARGB(127, 255, 157, 190),
          child: ListView(
            children: [
              // helper
              Card(
                clipBehavior: Clip.hardEdge,
                margin:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    horizontalTitleGap: 0,
                    subtitle: Image.asset("images/helper.gif",
                        fit: BoxFit.fill, height: 148),
                    title: Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          Container(child: Icon(Icons.search)),
                          Expanded(
                            child: Text(
                              "What are you looking for ?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 12, 35)),
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: Search(listt: listsearch));
                    },
                  ),
                ),
              ),

              //Section
              Card(
                margin:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    height: 50,
                    padding:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                    width: double.infinity,
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      onTap: () {
                        Navigator.of(context).pushNamed('categories');
                      },
                      title: Text(
                        "Categories",
                        textScaleFactor: 1.5,
                        style:
                            TextStyle(color: Color.fromARGB(255, 82, 12, 35)),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      height: 145,
                      width: double.infinity,
                      child: GridView(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          children: [
                            //laptop
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Image.asset("images/section/laptop.jpg",
                                    fit: BoxFit.fitHeight),
                                onTap: () {
                                  Navigator.of(context).pushNamed('laptops');
                                },
                              ),
                            ),
                            //smart Phones
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 1),
                                    child: Image.asset(
                                        "images/section/phon.jpg",
                                        fit: BoxFit.fitHeight)),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('smart phones');
                                },
                              ),
                            ),
                            //Tablets
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 11),
                                    child: Image.asset(
                                        "images/section/tablet.jpg",
                                        fit: BoxFit.fitHeight)),
                                onTap: () {
                                  Navigator.of(context).pushNamed('tablets');
                                },
                              ),
                            ),
                            //Smart TV
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 5),
                                    child: Image.asset("images/section/tv.jpg",
                                        fit: BoxFit.fitHeight)),
                                onTap: () {
                                  Navigator.of(context).pushNamed('smart Tvs');
                                },
                              ),
                            ),
                            //Watch
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 10),
                                    child: Image.asset(
                                        "images/section/watch.jpg",
                                        fit: BoxFit.fitHeight)),
                                onTap: () {
                                  Navigator.of(context).pushNamed('watchs');
                                },
                              ),
                            ),
                            //headhpon
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 0),
                                    child: Image.asset(
                                        "images/section/headphon.jpg",
                                        fit: BoxFit.fitHeight)),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('head phones');
                                },
                              ),
                            ),
                            //mor
                            Container(
                              height: 120,
                              width: 100,
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 25, right: 0, bottom: 20),
                                    child: Icon(
                                      Icons.control_point_duplicate_rounded,
                                      size: 50,
                                      color: Colors.black26,
                                    )),
                                onTap: () {
                                  Navigator.of(context).pushNamed('categories');
                                },
                              ),
                            ),
                          ])),
                ]),
              ),
              //offers
              Card(
                margin:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.white,
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      title: Text(
                        "Offers",
                        style:
                            TextStyle(color: Color.fromARGB(255, 82, 12, 35)),
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(
                      height: 300,
                      child: FutureBuilder(
                          future: getOffer(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return CarouselSlider(
                                items: buildCarouselItems(snapshot.data),
                                options: CarouselOptions(
                                    height: 310,
                                    autoPlay: true,

                                    //طريقة الانتقال بين العناصر
                                    autoPlayCurve: Curves.elasticOut),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          })),
                ]),
              ),
              //new
              Card(
                margin:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(children: [
                  Container(
                    height: 50,
                    color: Colors.white,
                    width: double.infinity,
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      title: Text(
                        "New items",
                        style:
                            TextStyle(color: Color.fromARGB(255, 82, 12, 35)),
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(
                      height: 300,
                      child: FutureBuilder(
                        future: getNew(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    color: Colors.white,
                                    child: InkWell(
                                      child: GridTile(
                                          child: Image.network(
                                              'http://10.0.2.2/mastershop/mastershopproduct/${snapshot.data[i]['image'].toString()}',
                                              fit: BoxFit.contain),
                                          footer: Container(
                                            margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 0,
                                                top: 9,
                                                right: 0,
                                                bottom: 0),
                                            color: Color.fromARGB(136, 0, 0, 0),
                                            height: 30,
                                            child: Text(
                                              snapshot.data[i]['productname']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                      onTap: () {
                                        godetails(
                                          snapshot.data[i]['productid'],
                                          snapshot.data[i]['catid'],
                                        );
                                      },
                                    ));
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ))
                ]),
              ),
            ],
          ),
        ));
  }
}

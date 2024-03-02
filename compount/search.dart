// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mastershop/compount/productview.dart';
//import 'package:flutter_icons/flutter_icons.dart';

class Search extends SearchDelegate<String> {
  List<dynamic> listt;
  Search({required this.listt});

  //fitch data
  Future getData() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchproduct.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getlap() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchlaptop.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getphone() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchphone.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future gettablet() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchtablet.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future gettv() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchtv.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getwatch() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchwatch.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getheadphone() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchheadphone.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getprice() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchprice.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getcompany() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/searchcompany.php');
    var data = {"pro": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Color.fromARGB(204, 233, 30, 98),
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  List<Widget>? buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icon Ledng
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results Search
    return Container(
      color: Color.fromARGB(127, 255, 157, 190),
      child: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Color.fromARGB(204, 233, 30, 98),
            labelColor: Color.fromARGB(204, 233, 30, 98),
            isScrollable: true,
            tabs: [
              new Tab(
                child: Text(
                  "all",
                ),
              ),
              new Tab(
                child: Text("laptops"),
              ),
              new Tab(
                child: Text("phones"),
              ),
              new Tab(
                child: Text("tablets"),
              ),
              new Tab(
                child: Text("TVs"),
              ),
              new Tab(
                child: Text("watchs"),
              ),
              new Tab(
                child: Text("headphones"),
              ),
              new Tab(
                child: Text("price"),
              ),
              new Tab(
                child: Text("company"),
              ),
            ],
          ),
          body: TabBarView(children: [
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getlap(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getphone(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: gettablet(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: gettv(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getwatch(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getheadphone(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getprice(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                                  "images/search_not_found/not_found.gif")),
                          Text(
                            "No result!",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(204, 233, 30, 98)),
                          ),
                          Text(
                            "Please try another word",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(204, 233, 30, 98)),
                          )
                        ],
                      );
                    }
                  }),
            ),
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: FutureBuilder(
                  future: getcompany(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                    "images/search_not_found/not_found.gif")),
                            Text(
                              "No result!",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            ),
                            Text(
                              "Please try another word",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(204, 233, 30, 98)),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Productlist(
                                id: snapshot.data[i]['productid'],
                                name:
                                    snapshot.data[i]['productname'].toString(),
                                company: snapshot.data[i]['company'].toString(),
                                date: snapshot.data[i]['datofpublication']
                                    .toString(),
                                price: snapshot.data[i]['price'].toString(),
                                cat: snapshot.data[i]['catid'],
                                pimage: snapshot.data[i]['image'].toString(),
                              );
                            });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchs for somehing

    var searchlist = query.isEmpty
        ? listt
        : listt.where((p) => p.startsWith(query)).toList();
    return Container(
      color: Color.fromARGB(127, 255, 157, 190),
      child: ListView.builder(
          itemCount: searchlist.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(Icons.devices),
              title: Text(searchlist[i]),
              onTap: () {
                query = searchlist[i];
                showResults(context);
              },
            );
          }),
    );
  }
}
  


/*ListView.builder(
          itemCount: searchlist.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(Icons.devices),
              title: Text(searchlist[i]),
              onTap: () {
                query = searchlist[i];
                showResults(context);
              },
            );
          }), */  
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../compount/mydrwer.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 27, opacity: 7),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontStyle: FontStyle.italic,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black,
                )
              ]),
          title: Text(
            "Gategories",
            style: TextStyle(fontFamily: "Bold Italic Art"),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromARGB(204, 233, 30, 98),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              splashRadius: 2,
            )
          ]),
      drawer: MyDrawer(),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(127, 255, 157, 190),
          child: GridView(
            scrollDirection: Axis.vertical,
            //semanticChildCount: 1,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            children: [
              //laptop
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  child: ListTile(
                    title: Image.asset("images/section/laptop.jpg",
                        fit: BoxFit.fitHeight),
                    subtitle: Container(
                        child: Text(
                      "Laptops",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 27),
                    )),
                    onTap: () {
                      Navigator.of(context).pushNamed('laptops');
                    },
                  ),
                ),
              ),

              //smart Phones
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  child: ListTile(
                    title: Container(
                        margin: EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 30),
                        child: Image.asset("images/section/phon.jpg",
                            fit: BoxFit.fitHeight)),
                    subtitle: Container(
                        child: Text(
                      "Smart phones",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 27),
                    )),
                    onTap: () {
                      Navigator.of(context).pushNamed('smart phones');
                    },
                  ),
                ),
              ),

              //Tablets
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: ListTile(
                  title: Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 15),
                      child: Image.asset("images/section/tablet.jpg",
                          fit: BoxFit.fitHeight)),
                  subtitle: Container(
                      child: Text(
                    "Tablets",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27),
                  )),
                  onTap: () {
                    Navigator.of(context).pushNamed('tablets');
                  },
                ),
              ),

              //Smart TV
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: ListTile(
                  title: Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 20, right: 0, bottom: 15),
                      child: Image.asset("images/section/tv.jpg",
                          fit: BoxFit.fitHeight)),
                  subtitle: Container(
                      child: Text(
                    "Smart TVs",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27),
                  )),
                  onTap: () {
                    Navigator.of(context).pushNamed('smart Tvs');
                  },
                ),
              ),

              //Watch
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: ListTile(
                  title: Container(
                      margin:
                          EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 6),
                      child: Image.asset("images/section/watch.jpg",
                          fit: BoxFit.fitHeight)),
                  subtitle: Container(
                      child: Text(
                    "Watchs",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27),
                  )),
                  onTap: () {
                    Navigator.of(context).pushNamed('watchs');
                  },
                ),
              ),

              //headhpon
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                child: ListTile(
                  title: Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 10, right: 0, bottom: 12),
                      child: Image.asset("images/section/headphon.jpg",
                          fit: BoxFit.fitHeight)),
                  subtitle: Container(
                      child: Text(
                    "Head phones",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27),
                  )),
                  onTap: () {
                    Navigator.of(context).pushNamed('head phones');
                  },
                ),
              ),
            ],
          )),
    );
  }
}

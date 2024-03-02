// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:mastershop/compount/rate.dart';
import 'package:mastershop/pages/account.dart';
import 'package:mastershop/pages/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String firstname = "";
  String lastname = "";
  String email = "";

  bool isSign = false;
  bool onDetails = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstname = preferences.getString("firstname")!;
      lastname = preferences.getString("lastname")!;
      email = preferences.getString("email")!;
      isSign = true;
    });
  }

  void initState() {
    getPref();
    super.initState();
  }

  rateicon() {
    return showDialog(
        context: context,
        builder: (context) {
          return Rat();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 85,
        child: Drawer(
          backgroundColor: Color.fromARGB(176, 236, 85, 135),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                //سهم  التفاصيل
                onDetailsPressed: () {
                  setState(() {
                    onDetails = !onDetails;
                  });
                },

                accountName: isSign
                    ? Row(
                        children: [
                          Text(firstname, textScaleFactor: 1.3),
                          Text(" ", textScaleFactor: 1.3),
                          Text(lastname, textScaleFactor: 1.3),
                        ],
                      )
                    : Text(" ", textScaleFactor: 1.3),
                accountEmail:
                    isSign ? Text(email) : Text(" ", textScaleFactor: 1.3),
                currentAccountPicture: (CircleAvatar(
                    child: Icon(Icons.person), backgroundColor: Colors.pink)),
                currentAccountPictureSize: const Size.fromRadius(35),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/drawer.jpg"),
                        fit: BoxFit.cover)),
              ),
              onDetails
                  ? Center(
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(40, 236, 229, 231),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Change account",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )),
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "wrning!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text(
                                      "Are you sure you want to Change account?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.remove("firstname");
                                          preferences.remove("lastname");
                                          preferences.remove("email");

                                          Navigator.of(context)
                                              .pushNamed('login');
                                          setState(() {
                                            isSign = false;
                                          });
                                        },
                                        child: Text("Change account")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("cancel")),
                                  ],
                                );
                              });
                        },
                      ),
                    )
                  : Container(),
              ListTile(
                title: Text(
                  "Home",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                ),
                leading: Icon(Icons.home,
                    size: 30, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 18, right: 0, bottom: 15),
                /*onLongPress: () {
                  print("onlongpress");
                },*/
                onTap: () {
                  Navigator.of(context).pushNamed('homepage');
                },
              ),
              ListTile(
                title: Text(
                  "Your account",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                ),
                leading: Icon(Icons.account_box,
                    size: 30, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 0, right: 0, bottom: 15),
                onTap: () {
                  isSign
                      ? Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                          return AccountPage(
                            email: email,
                          );
                        }))
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Sorry!",
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text(
                                  "You don't have an account.\nPlease creat a new account or login"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pushNamed('login');
                                    },
                                    child: Text("login")),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pushNamed('logup');
                                    },
                                    child: Text("creat account")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("cancel")),
                              ],
                            );
                          });
                },
              ),
              ListTile(
                title: Text(
                  "Categories",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                ),
                leading: Icon(Icons.widgets,
                    size: 30, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 0, right: 0, bottom: 15),
                onTap: () {
                  Navigator.of(context).pushNamed('categories');
                },
              ),
              ListTile(
                title: Text(
                  "Complaint",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                ),
                leading: Icon(Icons.report_problem_rounded,
                    size: 30, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 0, right: 0, bottom: 15),
                onTap: () {
                  Navigator.of(context).pushNamed("complaint");
                },
              ),
              Divider(
                color: Color.fromARGB(125, 255, 255, 255),
                indent: 150, endIndent: 5,
                thickness: 3,
                // color: Colors.black,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "About app",
                      textScaleFactor: 1.3,
                      style:
                          TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                    ),
                  ],
                ),
                minLeadingWidth: 2,
                trailing: Icon(Icons.question_mark_sharp,
                    size: 20, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
                onTap: () {
                  Navigator.of(context).pushNamed("aboutapp");
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Rate app",
                      textScaleFactor: 1.3,
                      style:
                          TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
                    ),
                  ],
                ),
                minLeadingWidth: 2,
                trailing: Icon(Icons.star_rate_rounded,
                    size: 20, color: Color.fromARGB(125, 255, 255, 255)),
                contentPadding:
                    EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
                onTap: () {
                  Navigator.of(context).pop();
                  rateicon();
                },
              ),
              isSign
                  ? ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Log out",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                color: Color.fromARGB(125, 255, 255, 255)),
                          ),
                        ],
                      ),
                      minLeadingWidth: 2,
                      trailing: Icon(Icons.logout_outlined,
                          size: 20, color: Color.fromARGB(125, 255, 255, 255)),
                      contentPadding: EdgeInsets.only(
                          left: 0, top: 0, right: 10, bottom: 0),
                      onTap: () {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "wrning!",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content:
                                    Text("Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.remove("firstname");
                                        preferences.remove("lastname");
                                        preferences.remove("email");

                                        Navigator.of(context)
                                            .pushNamed('login');
                                        setState(() {
                                          isSign = false;
                                        });
                                      },
                                      child: Text("log out")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("cancel")),
                                ],
                              );
                            });
                      },
                    )
                  : ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Log in",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                color: Color.fromARGB(125, 255, 255, 255)),
                          ),
                        ],
                      ),
                      minLeadingWidth: 2,
                      trailing: Icon(Icons.login_outlined,
                          size: 20, color: Color.fromARGB(125, 255, 255, 255)),
                      contentPadding: EdgeInsets.only(
                          left: 0, top: 0, right: 10, bottom: 0),
                      onTap: () {
                        Navigator.of(context).pushNamed("login");
                      },
                    ),
            ],
          ),
        ));
  }
}

// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

showdialog(context, String mytitle, String myconten) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mytitle),
          content: Text(myconten),
          actions: [
            IconButton(
              icon: Text(
                "OK",
                style: TextStyle(
                    color: Color.fromARGB(204, 233, 30, 98), fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

showdialogall(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("loading ...."),
        );
      });
}

class _SignupState extends State<Signup> {
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  bool show = false;
  bool show1 = false;

  GlobalKey<FormState> signup = new GlobalKey<FormState>();

  savePref(String firstname, String lastname, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("firstname", firstname);
    preferences.setString("lastname", lastname);
    preferences.setString("email", email);
    preferences.setInt("showrate", 1);
  }

  dataup() async {
    if (signup.currentState!.validate()) {
      signup.currentState!.save();
      showdialogall(context);
      var data = {
        "firstname": firstname.text,
        "lastname": lastname.text,
        "email": email.text,
        "mobile": phone.text,
        "password": password.text
      };

      var url = Uri.parse("http://10.0.2.2/mastershop/signup.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);

      if (responsebody['status'] == "success") {
        savePref(responsebody['firstname'], responsebody['lastname'],
            responsebody['email']);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("homepage");
      } else {
        print("email already found");
        showdialog(context, "Faild ", "email already exists");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromARGB(255, 122, 103, 103),
          ),
          Positioned(
            child: Transform.translate(
              offset: Offset(0, -MediaQuery.of(context).size.width / 1.33),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Color.fromARGB(204, 230, 52, 111),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  Avatar(context),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Form(
                        key: signup,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: firstname,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "can't be empty";
                                  }
                                  if (value.trim().length < 2) {
                                    return "can't be less than 2 letters";
                                  }
                                  if (value.trim().length > 50) {
                                    return "can't be mor than 50 letters";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "First Name",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: lastname,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "can't be empty";
                                  }
                                  if (value.trim().length < 2) {
                                    return "can't be less than 2 letters";
                                  }
                                  if (value.trim().length > 50) {
                                    return "can't be mor than 50 letters";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Last Name",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: email,
                                validator: (value) {
                                  if (!value!.trim().contains('@')) {
                                    return "Email must contain '@'";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Email",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: phone,
                                validator: (value) {
                                  if (value!.trim().length != 8) {
                                    return "must contain 10 number";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixText: "09",
                                  prefixStyle: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  filled: true,
                                  labelText: "Mobile Number",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                obscureText: show ? false : true,
                                controller: password,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "can't be empty";
                                  }
                                  if (value.trim().length < 5) {
                                    return "can't be less than 5 letters";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Password",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                      icon: show
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off)),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                obscureText: show1 ? false : true,
                                controller: confirmpassword,
                                validator: (value) {
                                  if (value! != password.text) {
                                    return "Password don't match!";
                                  }
                                },
                                cursorHeight: 30,
                                cursorColor: Color.fromARGB(204, 233, 30, 98),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Confirm Password",
                                  prefixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIconColor:
                                      Color.fromARGB(204, 233, 30, 98),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          show1 = !show1;
                                        });
                                      },
                                      icon: show1
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off)),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color.fromARGB(204, 233, 30, 98),
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 157, 190),
                                      )),
                                ),
                              ),
                            ),
                            InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Color.fromARGB(204, 233, 30, 98),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "    SIGN UP    ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  dataup();
                                }
                                /**/
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 5),
                                    child: Text(
                                      "Have an account ?",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                      selectionColor:
                                          Color.fromARGB(255, 255, 157, 190),
                                    )),
                                InkWell(
                                  child: Container(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 5),
                                      child: Text(
                                        '   Sign in',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(204, 233, 30, 98),
                                        ),
                                        selectionColor:
                                            Color.fromARGB(255, 255, 157, 190),
                                      )),
                                  onTap: () {
                                    Navigator.of(context).pushNamed("login");
                                  },
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                              top: 180,
                            )),
                          ],
                        )),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Stack Avatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 13),
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.width / 3.5,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 3.5),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 122, 103, 103), spreadRadius: 3)
            ],
            color: Color.fromARGB(204, 233, 30, 98),
          ),
          child: CircleAvatar(
              backgroundColor: Color.fromARGB(204, 233, 30, 98),
              child: Transform.translate(
                offset: Offset(-(MediaQuery.of(context).size.width / 30), 2.5),
                child: Icon(
                  Icons.person_sharp,
                  color: Color.fromARGB(255, 122, 103, 103),
                  size: MediaQuery.of(context).size.width / 2.9,
                ),
              )),
        ),
        Positioned(
            child: Transform.translate(
          offset: Offset(MediaQuery.of(context).size.width / 4.8,
              MediaQuery.of(context).size.width / 3.5),
          child: InkWell(
            child: Container(
                width: MediaQuery.of(context).size.width / 13,
                height: MediaQuery.of(context).size.width / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 3.5),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 122, 103, 103),
                        spreadRadius: 3)
                  ],
                  color: Color.fromARGB(204, 233, 30, 98),
                ),
                child: Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 122, 103, 103),
                  size: MediaQuery.of(context).size.width / 16,
                )),
            onTap: () {},
          ),
        ))
      ],
    );
  }
}

//decoration:BoxDecoration(borderRadius: BorderRadius.circular(30))


// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChangeAccount extends StatefulWidget {
  final email;
  final password;
  ChangeAccount({this.email, this.password});
  @override
  State<ChangeAccount> createState() =>
      _ChangeAccount(oldemail: this.email, oldpassword: this.password);
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

class _ChangeAccount extends State<ChangeAccount> {
  final oldemail;
  final oldpassword;
  _ChangeAccount({this.oldemail, this.oldpassword});

  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController password1 = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  GlobalKey<FormState> chang = new GlobalKey<FormState>();

  bool show = false;
  bool show1 = false;

  savePref(String firstname, String lastname, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("firstname", firstname);
    preferences.setString("lastname", lastname);
    preferences.setString("email", email);
  }

  dataup() async {
    if (chang.currentState!.validate()) {
      if (password1.text == oldpassword) {
        showdialogall(context);

        var data = {
          "firstname": firstname.text,
          "lastname": lastname.text,
          "email": this.oldemail.toString(),
          "mobile": phone.text,
          "password": password.text
        };

        var url = Uri.parse("http://10.0.2.2/mastershop/changeaccount.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);

        if (responsebody['status'] == "success") {
          savePref(responsebody['firstname'], responsebody['lastname'],
              responsebody['email']);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showdialog(context, "Done ", "account enformation has changed");
        } else {
          Navigator.of(context).pop();
          showdialog(context, "Faild ", "account not found");
        }
      } else {
        showdialog(context, "Faild ", "password is wrong..");
      }
    } else {
      showdialog(context, "Warning ", "text fields can't be empty");
    }
  }

  GlobalKey<FormState> signup = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromARGB(255, 230, 203, 203),
          ),
          Positioned(
            child: Transform.translate(
              offset: Offset(0, -MediaQuery.of(context).size.width / 2),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(176, 236, 85, 135),
                ),
              ),
            ),
          ),
          Positioned(
            child: Transform.translate(
              offset: Offset(0, -MediaQuery.of(context).size.width / 2 - 50),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(204, 233, 30, 89),
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Form(
                      key: chang,
                      child: Column(
                        children: [
                          SizedBox(height: 130),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Enter Your Password",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              obscureText: show ? false : true,
                              controller: password1,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "New Information",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "New First Name",
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "New Last Name",
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
                              controller: phone,
                              validator: (value) {
                                if (value!.trim().length != 8) {
                                  return "must contain 10 number";
                                }
                              },
                              cursorHeight: 30,
                              cursorColor: Color.fromARGB(204, 233, 30, 98),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixText: "09",
                                prefixStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                filled: true,
                                labelText: "New Number",
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "New Password",
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                                  "    Change     ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                dataup();
                              }),
                          Padding(
                              padding: EdgeInsets.only(
                            top: 180,
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}

//decoration:BoxDecoration(borderRadius: BorderRadius.circular(30))


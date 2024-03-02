// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
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

class _LogInState extends State<LogIn> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  GlobalKey<FormState> signin = new GlobalKey<FormState>();
  bool show = false;

  savePref(String firstname, String lastname, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("firstname", firstname);
    preferences.setString("lastname", lastname);
    preferences.setString("email", email);
    preferences.setInt('showrate', 1);
  }

  datain() async {
    if (signin.currentState!.validate()) {
      signin.currentState!.save();

      showdialogall(context);
      var data = {"email": email.text, "password": password.text};
      var url = Uri.parse('http://10.0.2.2/mastershop/signin.php');
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        savePref(responsebody['firstname'], responsebody['lastname'],
            responsebody['email']);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("homepage");
      } else {
        showdialog(context, "Faild ", "email or password is wrong..");
      }
    } else {}
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
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 2.2,
                  )),
                  Container(
                      width: 330,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        'welcome               ',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                        selectionColor: Color.fromARGB(255, 255, 157, 190),
                      )),
                  Container(
                      width: 330,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        '  Sing in to your account                                    ',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        selectionColor: Color.fromARGB(255, 255, 157, 190),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Form(
                        key: signin,
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
                                    color: Color.fromARGB(190, 255, 255, 255),
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
                                    return "can't be less than 2 letters";
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
                                    color: Color.fromARGB(190, 255, 255, 255),
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
                                  margin: EdgeInsets.only(top: 80, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Color.fromARGB(204, 233, 30, 98),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "    SIGN IN    ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: datain),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 5),
                                    child: Text(
                                      "Don't have an account ?",
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
                                        '   Sign up',
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
                                    Navigator.of(context).pushNamed("logup");
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
}

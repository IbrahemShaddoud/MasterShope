import 'package:mastershop/pages/home.dart';
import 'package:mastershop/pages/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  initState() {
    checkSignIn();
    super.initState();
  }

  checkSignIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString("email") == null) {
      Navigator.of(context).pushNamed("intro");
    } else
      Navigator.of(context).pushNamed("homepage");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 185, 130, 148),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/logo/icon.png"),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

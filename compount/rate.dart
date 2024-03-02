import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Rat extends StatefulWidget {
  const Rat({Key? key}) : super(key: key);

  @override
  State<Rat> createState() => _RatState();
}

class _RatState extends State<Rat> {
  TextEditingController review = new TextEditingController();
  double rating = 0;
  String id = "";

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

  void initState() {
    getid();
    super.initState();
  }

  rate() async {
    var data = {
      "userid": id,
      "ratevalue": rating.toString(),
      "review": review.text
    };
    var url = Uri.parse('http://10.0.2.2/mastershop/rate.php');
    await http.post(url, body: data);
    print(review.text);
  }

  @override
  Widget build(BuildContext context) {
    buildRating() {
      return RatingBar.builder(
        allowHalfRating: true,
        updateOnDrag: true,
        glowColor: Colors.white,
        unratedColor: Color.fromARGB(131, 241, 144, 144),
        itemSize: 50,
        minRating: 1,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Color.fromARGB(255, 235, 101, 101),
        ),
        onRatingUpdate: (rating) => setState(() {
          this.rating = rating;
        }),
      );
    }

    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 228, 220, 220),
      title: Text(
        "Rate Master Shope",
        style: TextStyle(color: Colors.red),
      ),
      content: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 80,
                child: Image.asset(
                  "images/logo/2.jpg",
                  fit: BoxFit.fill,
                )),
            buildRating(),
            const SizedBox(
              height: 15,
            ),
            Text(
              rating.toString(),
              style: TextStyle(fontSize: 35, color: Colors.red),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: review,
              cursorHeight: 30,
              cursorColor: Color.fromARGB(255, 235, 101, 101),
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                hintText: "Add a review",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 235, 101, 101),
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
      actions: [
        TextButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setInt('showrate', 0);
              rate();
              Navigator.of(context).pop();
            },
            child: Text("Ok")),
        TextButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setInt('showrate', 1);
              Navigator.of(context).pop();
            },
            child: Text("Maybe later")),
        TextButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setInt('showrate', 0);
              Navigator.of(context).pop();
            },
            child: Text("Don't show again")),
      ],
    );
  }
}

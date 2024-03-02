// ignore_for_file: prefer_const_constructors, duplicate_import

import 'package:flutter/material.dart';
import 'package:mastershop/pages/aboutapp.dart';
import 'package:mastershop/pages/checksingin.dart';
import 'package:mastershop/pages/onboard.dart';
import 'package:mastershop/pages/complaint.dart';
import 'package:mastershop/pages/details/laptopdetails.dart';
import 'package:mastershop/pages/headphones.dart';
import 'package:mastershop/pages/laptops.dart';
import 'package:mastershop/pages/signin.dart';
import 'package:mastershop/pages/phones.dart';
import 'package:mastershop/pages/singup.dart';
import 'package:mastershop/pages/tablets.dart';
import 'package:mastershop/pages/tvs.dart';
import 'package:mastershop/pages/watchs.dart';
import 'game.dart';
import 'pages/home.dart';
import 'pages/categories.dart';
import 'pages/details/laptopdetails.dart';
import 'pages/details/phonedetails.dart';
import 'pages/details/tabletdetails.dart';
import 'pages/details/tvdetails.dart';
import 'pages/details/watchdetails.dart';
import 'pages/details/headphonedetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MasterShop",
      home: IntroOverboardPage(),
      routes: {
        'categories': (context) {
          return Categories();
        },
        'homepage': (context) {
          return Home();
        },
        'laptops': (context) {
          return Laptops();
        },
        'smart phones': (context) {
          return Phones();
        },
        'tablets': (context) {
          return Tablets();
        },
        'smart Tvs': (context) {
          return Tvs();
        },
        'watchs': (context) {
          return Watchs();
        },
        'head phones': (context) {
          return Headphones();
        },
        'laptopdetails': (context) {
          return Lapdetails();
        },
        'phonedetails': (context) {
          return Phonedetails();
        },
        'tabletdetails': (context) {
          return Tabletdetails();
        },
        'tvdetails': (context) {
          return Tvdetails();
        },
        'watchdetails': (context) {
          return Watchdetails();
        },
        'headphonedetails': (context) {
          return Headphonedetails();
        },
        'login': (context) {
          return LogIn();
        },
        'logup': (context) {
          return Signup();
        },
        'complaint': (context) {
          return Complaint();
        },
        'intro': (context) {
          return IntroOverboardPage();
        },
        'aboutapp': (context) {
          return About();
        },
      },
    );
  }
}

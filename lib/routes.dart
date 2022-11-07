import 'package:flutter/material.dart';
import 'package:mybook/pages/home/home.dart';
import 'package:mybook/pages/login/login.dart';
import 'package:mybook/pages/splash/splash.dart';
import 'package:mybook/pages/tambahdata/add.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routesName: (context) => const Splash(),
  Login.routesName: (context) => const Login(),
  Home.routesName: (context) => const Home(),
  Add.routesName: (context) => const Add(),
};

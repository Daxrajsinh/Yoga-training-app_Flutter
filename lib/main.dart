import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/SplashScreen.dart';
import 'package:flutter_yoga/register.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(isLoggedIn: false),
    },
  ));
}
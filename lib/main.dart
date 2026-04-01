import 'package:flutter/material.dart';
import 'package:life_patch/home.dart';
import 'package:life_patch/splash.dart';
import 'login.dart';
import 'signup.dart';
import 'solution.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Firebase Connected Successfully!");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => splash(),
        "/l": (context) => login(),
        "/s": (context) => signup(),
        //"/h": (context) => home(),
        //"/so" : (context) => solution(),
      },
    );
  }
}


// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/auth/login.dart';
import 'package:fluttercourse/auth/signup.dart';
import 'package:fluttercourse/categories/add.dart';
import 'package:fluttercourse/filter.dart';
import 'package:fluttercourse/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '================================== User is currently signed out!');
      } else {
        print('================================== User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[50],
              titleTextStyle: TextStyle(
                  color: Colors.orange,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.orange))),
      debugShowCheckedModeBanner: false,
      home:FilterFirestore() , 
      //  (FirebaseAuth.instance.currentUser != null &&
      //         FirebaseAuth.instance.currentUser!.emailVerified)
      //     ? Homepage()
      //     : Login(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "homepage": (context) => Homepage()  , 
        "addcategory": (context) => AddCategory()  , 
        "filterfirestore" : (context) => FilterFirestore()
      },
    );
  }
}

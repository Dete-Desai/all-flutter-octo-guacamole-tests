import 'package:flutter/material.dart';
import 'Presentation/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var fsconnect = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

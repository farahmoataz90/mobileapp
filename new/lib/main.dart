import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:training_project/firebase_options.dart';
//import 'package:training_project/home/components/homeScreen.dart';
import 'package:training_project/myApplication.dart';
import 'package:training_project/screens/auth_page.dart';
import 'package:training_project/screens/login.dart';
import 'package:training_project/screens/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

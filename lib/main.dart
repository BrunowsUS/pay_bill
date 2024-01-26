import 'package:flutter/material.dart';
import 'package:pay_bill/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'assets/Firebase/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: ContasApp(),
  ));
}

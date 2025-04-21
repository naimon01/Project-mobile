import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectmobile/signin.dart';
import 'package:projectmobile/welcome.dart';
import 'firebase_options.dart'; // auto generated selepas setup firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farming',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SmartFarmingWelcomeScreen(),
    );
  }
}

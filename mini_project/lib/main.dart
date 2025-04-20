import 'package:flutter/material.dart';
import 'package:mini_project/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  Widget build(BuildContext context){
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
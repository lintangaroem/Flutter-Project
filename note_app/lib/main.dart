import 'package:flutter/material.dart';
import 'package:note_app/pages/note_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  Widget build(BuildContext context){
    return const MaterialApp(
      home: NotePage(),
    );
  }
}
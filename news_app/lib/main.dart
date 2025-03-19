import 'package:flutter/material.dart';
import 'package:news_app/news_page.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  Widget build(BuildContext context){
    return const MaterialApp(
      home: NewsPage(),
    );
  }
}
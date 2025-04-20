import 'package:flutter/material.dart';
import 'package:mini_project/pages/calendar.dart';
import 'package:mini_project/pages/notes.dart';
import 'package:mini_project/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _currentNavIndex = 0;

  void _onNavItemTapped(int index){
    setState(() {
      _currentNavIndex = index;
    });

    if(index == 1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalendarPage()),
      );
    }else if(index == 2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotePage()),
      );
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Greating Header
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Lintang!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D009D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Let\'s get productive all the day',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0D009D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              //To Do list

              //Notes
            ],
          ),
        ),
      ),

      //navbar
      bottomNavigationBar: BottomNavbar(
          currentIndex: _currentNavIndex,
          onTap: _onNavItemTapped,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Widget>? pages;
  final BuildContext? context;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.pages,
    this.context,
  });

  void _handleTap(int index, BuildContext context){
    onTap(index);

    if(pages != null && pages!.length > index){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pages![index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _handleTap(index, this.context ?? context),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 32),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 25),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined, size: 28),
              label: "Notes",
            ),
          ],
          selectedItemColor: const Color(0xFF0D009D),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
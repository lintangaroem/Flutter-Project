import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/widgets/bottom_navbar.dart';
import 'package:mini_project/pages/home.dart';
import 'package:mini_project/pages/calendar.dart';
import 'package:mini_project/widgets/add_note.dart';
import 'package:mini_project/widgets/show_note.dart';
import 'package:mini_project/models/note.dart';
import 'package:mini_project/database/note_database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  int _currentNavIndex = 2;
  List<Note> notes = [];
  bool isLoading = false;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CalendarPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    setState(() => isLoading = true);

    try {
      final loadedNotes = await NoteDatabase.instance.getAllNotes();
      setState(() => notes = loadedNotes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notes: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Color(0xFF0D009D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF3F6FF),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 4,
            ),
            itemCount: notes.length + 1, // +1 for the add note card
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildAddNoteCard(context);
              } else {
                final note = notes[index - 1];
                return _buildNoteCard(note);
              }
            },
          ),
        )
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentNavIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  Widget _buildAddNoteCard(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNotePage()),
        );
        refreshNotes(); // Refresh notes after returning
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 48,
                color: Color(0xFF0D009D),
              ),
              SizedBox(height: 8),
              Text(
                'Add Note',
                style: TextStyle(
                  color: Color(0xFF0D009D),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowNotePage(note: note)),
        );
        if (result == true) {
          refreshNotes(); // Kalau habis delete/edit, refresh list
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF0D009D),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, yyyy').format(DateTime.parse(note.date)),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                note.content,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }

}
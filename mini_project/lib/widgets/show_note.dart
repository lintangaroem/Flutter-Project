import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/models/note.dart';
import 'package:mini_project/database/note_database.dart';
import 'package:mini_project/widgets/add_note.dart';

class ShowNotePage extends StatefulWidget {
  final Note note;

  const ShowNotePage({super.key, required this.note});

  @override
  State<ShowNotePage> createState() => _ShowNotePageState();
}

class _ShowNotePageState extends State<ShowNotePage> {
  late Note note;

  @override
  void initState() {
    super.initState();
    note = widget.note;
  }

  Future<void> _deleteNote() async {
    await NoteDatabase.instance.deleteNoteById(note.id!);
    Navigator.pop(context, true); // Return true biar tahu data berubah
  }

  Future<void> _editNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage(note: note)),
    );
    final updatedNote = await NoteDatabase.instance.getNoteById(note.id!);
    if (updatedNote != null) {
      setState(() {
        note = updatedNote;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF0D009D)),
        title: const Text(
          'Note Details',
          style: TextStyle(
            color: Color(0xFF0D009D),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteNote();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await _editNote();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D009D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('MMM dd, yyyy').format(DateTime.parse(note.date)),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

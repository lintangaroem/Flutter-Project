import 'package:flutter/material.dart';
import 'package:mini_project/pages/calendar.dart';
import 'package:mini_project/pages/notes.dart';
import 'package:mini_project/widgets/bottom_navbar.dart';
import 'package:mini_project/models/task.dart';
import 'package:mini_project/models/note.dart';
import 'package:mini_project/database/task_database.dart';
import 'package:mini_project/database/note_database.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _currentNavIndex = 0;
  List<Task> _todayTasks = [];
  List<Note> _notes = [];

  void initState() {
    super.initState();
    _loadTodayTasks();
    _loadNotes();
  }

  void _loadTodayTasks() async {
    final today = DateTime.now();
    final tasks = await TaskDatabase.instance.getTasksByDate(today);
    setState(() {
      _todayTasks = tasks;
    });
  }

  void _loadNotes() async {
    final notes = await NoteDatabase.instance.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'To-Day',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D009D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: _todayTasks.isEmpty
                      ? [
                    const Text('No tasks for today'),
                  ]
                      : _sortedTasks().map((task) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Checkbox(
                            value: task.isDone,
                            onChanged: (bool? value) async {
                              setState(() {
                                task.isDone = value!;
                              });
                              await TaskDatabase.instance.updateTask(task);
                              setState(() {
                                // Trigger refresh setelah update
                              });
                            },
                            activeColor: task.isDone ? Colors.grey : const Color(0xFF0D009D),
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFF0D009D),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: task.isDone ? const Color(0xFFC5C5C5) : Colors.black,
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),

              //Notes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D009D),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotePage()),
                      );
                    },
                    child: const Text(
                      'Show All',
                      style: TextStyle(
                        color: Color(0xFF0D009D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _notes.isEmpty
                  ? const Text('No notes yet')
                  : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D009D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(note.date)),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              note.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
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

  List<Task> _sortedTasks() {
    List<Task> tasks = List.from(_todayTasks);
    tasks.sort((a, b) {
      if (a.isDone == b.isDone) {
        return 0;
      } else if (a.isDone) {
        return 1;
      } else {
        return -1;
      }
    });
    return tasks;
  }

}
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:mini_project/database/task_database.dart';
import 'package:mini_project/widgets/add_task_dialog.dart';
import 'package:mini_project/widgets/edit_task_dialog.dart';
import 'package:mini_project/widgets/bottom_navbar.dart';
import 'package:mini_project/pages/home.dart';
import 'package:mini_project/models/task.dart';
import 'package:mini_project/pages/notes.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget{
  const CalendarPage({super.key});
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  List<DateTime?> _selectedDates = [DateTime.now()];
  List<Task> _tasks = [];
  int _currentNavIndex = 1;
  bool isLoading = false;

  void initState(){
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => isLoading = true);

    try {
      final loadedTasks = await TaskDatabase.instance.getTasksByDate(_selectedDates.first!);

      loadedTasks.sort((a, b) {
        // Assuming time is in the format "HH:mm"
        final timeA = DateFormat("HH:mm").parse(a.time); // Modify according to your time format
        final timeB = DateFormat("HH:mm").parse(b.time); // Modify according to your time format
        return timeA.compareTo(timeB); // Sorting in ascending order
      });

      setState(() => _tasks = loadedTasks);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notes: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget build(BuildContext context){
    final selectedDate = _selectedDates.first!;
    final isToday = _isSameDay(selectedDate, DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(0xFF0D009D),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //calendar tampil
          _buildCalendar(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'My Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF0D009D)
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _showAddTaskDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D009D),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                )
              ],
            ),
          ),

          Expanded(
            child: _tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task, size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          isToday ? 'No tasks for today' : 'No tasks for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
            )
                : ListView.builder(
                itemCount: _tasks.length,
              itemBuilder: (context, index) {
                  return _buildTaskItem(_tasks[index]);
              },
            )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
          currentIndex: _currentNavIndex, 
          onTap: _onNavItemTapped,
      ),
    );
  }
  
  Widget _buildCalendar(){
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.single,
            selectedDayHighlightColor: const Color(0xFF0D009D),
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          ),
          value: _selectedDates,
        onValueChanged: (dates) async{
            setState(() {
              _selectedDates = dates;
            });
            await _loadTasks();
        },
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: Colors.white,
      child: ListTile(
        onTap: () => _showEditTaskDialog(context, task),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.time,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D009D)),
          ),
        ),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.description ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeTask(task),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final task = await showDialog<Task>(
      context: context,
      builder: (context) => AddTaskDialog(
        initialDate: _selectedDates.first!,
      ),
    );

    if (task != null) {
      await TaskDatabase.instance.create(task);
      await _loadTasks();
    }
  }

  Future<void> _removeTask(Task task) async {
    if (task.id != null) {
      await TaskDatabase.instance.deleteTask(task.id!);
      await _loadTasks();
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotePage()),
      );
    }
  }

  Future<void> _showEditTaskDialog(BuildContext context, Task task) async {
    final editedTask = await showDialog<Task>(
      context: context,
      builder: (context) => EditTaskDialog(
        initialTask: task,
      ),
    );

    if (editedTask != null) {
      await TaskDatabase.instance.updateTask(editedTask);
      await _loadTasks();
    }
  }
}
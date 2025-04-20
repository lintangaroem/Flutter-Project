import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:mini_project/widgets/add_task_dialog.dart';
import 'package:mini_project/widgets/bottom_navbar.dart';
import 'package:mini_project/pages/home.dart';
import 'package:mini_project/models/task.dart';
import 'package:mini_project/pages/notes.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<DateTime?> _selectedDates = [DateTime.now()]; // Default to today
  final Map<DateTime, List<Task>> _tasksByDate = {};
  int _currentNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    final selectedDate = _selectedDates.first!;
    final tasksForSelectedDate = _getTasksForDate(selectedDate);
    final isToday = _isSameDay(selectedDate, DateTime.now());

    return Scaffold(
      backgroundColor: Color(0xFFF3F6FF),
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
          // Calendar Widget
          _buildCalendar(),

          // Task Header with Date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'My Task',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF0D009D)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _showAddTaskDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D009D),
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                )
              ],
            ),
          ),

          // Task List for Selected Date
          Expanded(
              child: tasksForSelectedDate.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task, size: 48, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'Today\'s Task',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: tasksForSelectedDate.length,
                itemBuilder: (context, index) {
                  return _buildTaskItem(tasksForSelectedDate[index], selectedDate);
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

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          selectedDayHighlightColor: Color(0xFF0D009D),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ),
        value: _selectedDates,
        onValueChanged: (dates) => setState(() => _selectedDates = dates),
      ),
    );
  }

  Widget _buildTaskItem(Task task, DateTime date) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: Colors.white,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFF3F6FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.time,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D009D)),
          ),
        ),
        title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.description ?? ''),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeTask(task, date),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        initialDate: _selectedDates.first!,
        onTaskAdded: (newTask, taskDate) {
          setState(() {
            final dateKey = DateTime(taskDate.year, taskDate.month, taskDate.day);
            _tasksByDate[dateKey] ??= [];
            _tasksByDate[dateKey]!.add(newTask);
            _sortTasksByTime(dateKey);
          });
        },
      ),
    );
  }

  List<Task> _getTasksForDate(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    return _tasksByDate[dateKey] ?? [];
  }

  void _removeTask(Task task, DateTime date) {
    setState(() {
      final dateKey = DateTime(date.year, date.month, date.day);
      _tasksByDate[dateKey]?.remove(task);
      if (_tasksByDate[dateKey]?.isEmpty ?? false) {
        _tasksByDate.remove(dateKey);
      }
    });
  }

  void _sortTasksByTime(DateTime date) {
    _tasksByDate[date]?.sort((a, b) => a.time.compareTo(b.time));
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
    }else if(index == 2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotePage()),
      );
    }
  }
}
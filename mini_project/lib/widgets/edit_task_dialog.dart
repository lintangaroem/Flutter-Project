import 'package:flutter/material.dart';
import 'package:mini_project/models/task.dart';
import 'package:intl/intl.dart';

class EditTaskDialog extends StatefulWidget {
  final Task initialTask;

  const EditTaskDialog({Key? key, required this.initialTask}) : super(key: key);

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTask.title);
    _descriptionController = TextEditingController(text: widget.initialTask.description);
    selectedDate = DateTime.parse(widget.initialTask.date);
    final timeParts = widget.initialTask.time.split(':');
    selectedTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'Enter task title',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Date and Time Pickers
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xFF0D009D),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      DateFormat('MMM dd, yyyy').format(selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text(
                      '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Icon(
                      Icons.format_align_justify,
                      color: Color(0xFF0D009D),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        hintText: 'Enter task description',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Save and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a task title')),
                        );
                        return;
                      }

                      final newTask = Task(
                        id: widget.initialTask?.id, // kalau edit, id tetap
                        date: DateFormat('yyyy-MM-dd').format(selectedDate),
                        time: '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                        title: _titleController.text,
                        description: _descriptionController.text,
                      );
                      Navigator.pop(context, newTask);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D009D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Task {
  final String date;
  final String time;
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Task copyWith({
    String? time,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      date: date ?? this.date,
      time: time ?? this.time,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
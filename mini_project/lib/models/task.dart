class Task {
  final int? id;
  final String title;
  final String? description;
  final String date;
  final String time;
  bool isDone;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.date,
    required this.time,
    this.isDone = false,
  });

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'time': time,
    'isDone': isDone ? 1 : 0,
  };

  Task copy({
    int? id,
    String? title,
    String? description,
    String? date,
    String? time,
    bool? isDone,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        isDone: isDone ?? this.isDone,
      );

  static Task fromJson(Map<String, Object?> json) => Task(
    id: json['id'] as int?,
    title: json['title'] as String,
    description: json['description'] as String?,
    date: json['date'] as String,
    time: json['time'] as String,
    isDone: (json['isDone'] as int) == 1,
  );
}

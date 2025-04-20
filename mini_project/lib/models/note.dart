final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, content, date];

  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
  static const String date = 'date';
}

class Note {
  final int? id;
  final String title;
  final String content;
  final String date;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Note copy({int? id, String? title, String? content, String? date}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
      );

  Map<String, dynamic> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.content: content,
    NoteFields.date: date,
  };

  static Note fromJson(Map<String, dynamic> json) => Note(
    id: json[NoteFields.id] as int?,
    title: json[NoteFields.title] as String,
    content: json[NoteFields.content] as String,
    date: json[NoteFields.date] as String,
  );
}

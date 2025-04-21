import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mini_project/models/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      isDone INTEGER NOT NULL DEFAULT 0
    )
    ''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toJson());
    return task.copy(id: id);
  }

  Future<List<Task>> getTasksByDate(DateTime date) async {
    final db = await instance.database;
    final formattedDate =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final result = await db.query(
      'tasks',
      where: 'date = ?',
      whereArgs: [formattedDate],
    );
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;

    return await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

}

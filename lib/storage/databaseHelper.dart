import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class DatabaseHelper {
  final String _databaseName = 'todos.db';
  final String _tableTodo = 'todoTable';
  final String _columnId = 'id';
  final String _columnTitle = 'title';
  final String _columnIsChecked = 'isChecked';
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_tableTodo($_columnId INTEGER PRIMARY KEY, $_columnTitle TEXT, $_columnIsChecked INTEGER)');
  }

  Future<int> saveTodo(Todo todo) async {
    var dbClient = await db;
    var result = await dbClient.insert(_tableTodo, todo.toMap());

    return result;
  }

  Future<int> getCountTodos() async {
    var dbClient = await db;

    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $_tableTodo'));
  }

  Future<List<Todo>> getAllTodos() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient
        .query(_tableTodo, columns: [_columnId, _columnTitle, _columnIsChecked]);

    return List.generate(result.length, (index) {
      return Todo(
        id: result[index]['id'],
        title: result[index]['title'],
        isChecked: result[index]['isChecked'] == 1 ? true : false,
      );
    });
  }

  Future<int> updateTodo(Todo todo) async {
    var dbClient = await db;
    var todoUpdate = todo.toMap();

    return await dbClient.update(
      _tableTodo,
      todoUpdate,
      where: "$_columnId = ?",
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(_tableTodo, where: '$_columnId = ?', whereArgs: [id]);
  }
}

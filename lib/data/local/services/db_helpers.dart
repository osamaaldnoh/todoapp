import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:todoapp/data/local/tables/task_db.dart';
import 'package:todoapp/data/local/tables/user_db.dart';

class DBHelper
{
   Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    String path = await getDatabasesPath();
    String databasePath = p.join(path, "todo.db");

    return databasePath;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async {
    await database.transaction((txn) async {
     await TaskDB().createTable(txn.database);
     await UserDB().createTable(txn.database);
    });
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/local/services/db_helpers.dart';
import 'package:todoapp/data/local/services/db_types.dart';
import 'package:todoapp/data/local/table_name.dart';
import 'package:todoapp/model/task.dart';

class TaskDB
{
  Future<void> createTable(Database db)
  {
    return db.execute(
      "Create Table todos("
      "${TableName.idTask} ${DBType.idPrimary}, "
      "${TableName.title} ${DBType.stringType}, "
      "${TableName.desc} ${DBType.textType}, "
      "${TableName.date} ${DBType.stringType}, "
      "${TableName.startTime} ${DBType.stringType}, "
      "${TableName.endTime} ${DBType.stringType}, "
      "${TableName.remind} ${DBType.integerType}, "
      "${TableName.repeat} ${DBType.stringType}, "
      "${TableName.isCompleted} ${DBType.integerType})"
    );
  }

  Future<int> createTask(Task task)
  async
  {
    try{
      final db = await DBHelper().database;
      return await db.insert(TableName.tasksTBL, task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );

    }
    catch(e)
    {
      print("Error $e");
      return 404;
    }
  }

  Future<List<Task>> getAllTasks() async {
    final db = await DBHelper().database;

    final result = await db.query(TableName.tasksTBL);

    return result.map((e) => Task.fromJson(e)).toList();
  }

  Future<List<Map<String,dynamic>>> getTask(int id) async {
    final db = await DBHelper().database;

   
      return await db.query(
        TableName.tasksTBL,
        where: '${TableName.idTask} = ?',
        whereArgs: [id],
        limit: 1,
      );
   
     }

  Future<int?> updata(Task task) async {
    final db = await DBHelper().database;
    try {
      return await db.update(
        TableName.tasksTBL,
        task.toJson(),
        where: '${TableName.idTask} = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
     
      return 90000;
    }
  }

  Future<int> delete(Task task) async {
    try {
      final db = await DBHelper().database;
      return await db.delete(TableName.tasksTBL,
          where: '${TableName.idTask} = ?',
          whereArgs: [task.id]);
    } catch (e) {
      
      return 90000;
    }
  }

}
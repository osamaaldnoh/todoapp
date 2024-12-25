import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/local/services/db_helpers.dart';
import 'package:todoapp/data/local/services/db_types.dart';
import 'package:todoapp/data/local/table_name.dart';

import '../../../model/user_model.dart';

class UserDB
{
  Future<void> createTable(Database db)
  {
    return db.execute(
      "Create Table ${TableName.userTBL}("
      "${TableName.idUser} ${DBType.idPrimary}, "
      "${TableName.isVerified} ${DBType.integerType})"
    );
  }

  Future<int> createUser(UserModel user)
  async
  {
    try{
      final db = await DBHelper().database;
      return await db.insert(TableName.userTBL, user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );

    }
    catch(e)
    {
      print("Error $e");
      return 404;
    }
  }

  Future<List<Map<String,dynamic>>> getUser() async {
    final db = await DBHelper().database;

    final result = await db.query(TableName.userTBL,orderBy: 'id');

    return result;
  }

  Future<List<UserModel>> readAllUsers() async {
    final db = await DBHelper().database;

    final result = await db.query(TableName.userTBL);

    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<int?> updata(UserModel user) async {
    final db = await DBHelper().database;
    try {
      return await db.update(
        TableName.userTBL,
        user.toJson(),
        where: '${TableName.userTBL} = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
     
      return 90000;
    }
  }

  Future<int> delete(UserModel user) async {
    try {
      final db = await DBHelper().database;
      return await db.delete(TableName.userTBL,
          where: '${TableName.idUser} = ?',
          whereArgs: [user.id]);
    } catch (e) {
      
      return 90000;
    }
  }

}
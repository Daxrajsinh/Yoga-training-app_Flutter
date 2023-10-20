import 'package:flutter_yoga/model/model.dart';
import 'package:flutter_yoga/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class YogaDatabase {
  static final YogaDatabase instance = YogaDatabase._init();
  static Database? _database;
  YogaDatabase._init();

  Future<Database> _initalizeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initalizeDB("YogaStepsDB.db");
    return _database;
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = "INTEGER NOT NULL";
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    // id , bool(Seconds) , text

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable1}(${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
   ${YogaModel.ImageName} $textType,
   ${YogaModel.YogaKeyWorkOuts} $intType,
   ${YogaModel.SecondsOrTimes} $textType,
   ${YogaModel.SecondsOrNot} $boolType)''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable2}(
   ${YogaModel.IDName} $idType,
   ${YogaModel.YogaName} $textType,
   ${YogaModel.YogaKeyWorkOuts} $intType,
   ${YogaModel.ImageName} $textType,
   ${YogaModel.SecondsOrNot} $boolType,
  ${YogaModel.SecondsOrTimes} $textType)''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable3}(
   ${YogaModel.IDName} $idType,
   ${YogaModel.YogaName} $textType,
   ${YogaModel.ImageName} $textType,
   ${YogaModel.YogaKeyWorkOuts} $intType,
   ${YogaModel.SecondsOrNot} $boolType,
  ${YogaModel.SecondsOrTimes} $textType)''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaSummary}(
   ${YogaModel.IDName} $idType,
    ${YogaModel.YogaWorkOutName} $textType,
    ${YogaModel.YogaKey} $intType,
   ${YogaModel.BackImg} $textType,
   ${YogaModel.TimeTaken} $textType,
   ${YogaModel.TotalNoOfWork} $textType
   )''');

    await db.execute('''
    CREATE TABLE ${UserModel.UserTable}(
      ${UserModel.IDName} $idType,
      ${UserModel.Username} $textType,
      ${UserModel.Password} $textType
    )''');
  }

  Future<User?> insertUser(User user) async {
    final db = await instance.database;
    final id = await db!.insert(UserModel.UserTable, user.toJson());
    return user.copy(id: id);
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await instance.database;
    final map = await db!.query(UserModel.UserTable,
        where: '${UserModel.Username} = ?', whereArgs: [username]);
    if (map.isNotEmpty) {
      return User.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future<Yoga?> Insert(Yoga yoga, String TableName) async {
    final db = await instance.database;
    final id = await db!.insert(TableName, yoga.toJson());
    return yoga.copy(id: id);
  }

  Future<YogaSummary?> InsertYogaSum(YogaSummary yogasum) async {
    final db = await instance.database;
    final id = await db!.insert(YogaModel.YogaSummary, yogasum.toJson());
    return yogasum.copy(id: id);
  }

  Future<List<YogaSummary>> readAllYogaSum() async {
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(YogaModel.YogaSummary, orderBy: orderBy);
    return query_res.map((json) => YogaSummary.fromJson(json)).toList();
  }

  Future<List<Yoga>> readAllYoga(String TableName) async {
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(TableName, orderBy: orderBy);
    return query_res.map((json) => Yoga.fromJson(json)).toList();
  }

  Future<Yoga?> readOneYoga(int id, String TableName) async {
    final db = await instance.database;
    final map = await db!.query(TableName,
        columns: YogaModel.YogaTable1ColumnName,
        where: '${YogaModel.IDName} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Yoga.fromJson(map.first);
    } else {
      return null;
    }
  }
}
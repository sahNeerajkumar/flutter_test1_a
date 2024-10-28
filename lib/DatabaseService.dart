import 'dart:developer';
import 'package:flutter_test1/Model_Page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static final DatabaseServices _databaseService = DatabaseServices._internal();

  factory DatabaseServices() => _databaseService;

  DatabaseServices._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/teachers.db';
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Teacher(id TEXT PRIMARY KEY , name TEXT, email TEXT,contactNum TEXT, subject TEXT,school TEXT, image STRING)');
    log('TABLE CREATED');

    //Create Auth table for Login/singup
    await db.execute(
     'CREATE TABLE IF NOT EXISTS AUTH(id TEXT PRIMARY KEY, userName TEXT, userEmail TEXT, userPassword TEXT, isLogin INTEGER)',
    );
    log('AUTH TABLE CREATED');

  }
Future<void> insertAuthData(Map<String,dynamic> user) async{
    final authDb = await _databaseService.database;
    try{
      log('Inserting user into AUTH table: $user');
      var data = await authDb.insert('AUTH',user, conflictAlgorithm:ConflictAlgorithm.replace);
      log('User registered with ID: $data');
    }catch(e){
      log('Error during sing-up: $e');
    }
}

Future<List<Map<String, dynamic>>>getAuthData()async{
final db = await _databaseService.database;
return await db.query('AUTH');
}

Future<void> updateAuthData(String?id, Map<String,dynamic> updateAuth)async{
    final db = await _databaseService.database;
    await db.update('AUTH', updateAuth,
      where: 'id =?',
        whereArgs: [id]
    );
}







Future<List<UserModel>> getUser() async {
    final db = await _databaseService.database;
    try {
      var data = await db.rawQuery('SELECT * FROM Teacher');
      List<UserModel> teach =
      List.generate(data.length, (index) => UserModel.fromJson(data[index]));
      print(teach.length);
      return teach;
    } catch (e) {
      log("Error: $e");
      return [];
    }
  }
  Future<void> insertDate(UserModel userModel) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert(
        'INSERT INTO Teacher(id, name,email,contactNum,subject,school,image ) VALUES(?,?,?,?,?,?,?)',
        [userModel.id, userModel.name,userModel.email,userModel.contactNum, userModel.subject,userModel.school,userModel.image]);
    log('insertData $data');
  }
  Future<void> deleteMovie(String id) async {
    final db = await _databaseService.database;
    var data = await db.rawDelete(
        'DELETE from Teacher WHERE id=?', [id]);
    log('deleted $data');
  }
 Future<void> updateData(UserModel user) async{
    final db = await database;
    await db.update('Teacher', user.toMap(),
    where: 'id=?',
      whereArgs: [user.id],

    );
 }

}

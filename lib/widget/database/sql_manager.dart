import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlManager {
  static const _VERSION = 1;
  static const dbName = 'user.db';
  static Database _database;
  var createSql =
      "CREATE TABLE user (id INTEGER PRIMARY KEY, username TEXT, pwd TEXT)";

  ///初始化
  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {});
  }

  ///判断表是否存在
  static Future<bool> isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res=await _database.rawQuery("select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res!=null && res.length >0;
  }

  ///获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if(_database == null){
      await init();
    }
    return _database;
  }

  ///关闭
  static close() {
    _database?.close();
    _database = null;
  }
}

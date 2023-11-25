import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  final String tableName = 'ActiveDevicesTable';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'ActiveDevices.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    final String createTableSql = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT, 
        phonenumber INTEGER,
        devicestatus BOOLEAN,
        personalcode INTEGER
      )
    ''';
    await db.execute(createTableSql);
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(tableName, data);
  }

  Future<int> updateData(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<bool> checkDeviceStatus() async {
    final db = await database;
    final result =
        await db.query(tableName, where: 'devicestatus = ?', whereArgs: [true]);

    return result.isNotEmpty;
  }

  Future<String> getDeviceName() async {
    final db = await database;
    final result = await db.query(tableName);

    if (result.isNotEmpty) {
      return result[0]['name'] as String;
    } else {
      return 'Cihaz adı bulunamadı';
    }
  }

  Future<void> saveCode(int code) async {
    final Map<String, dynamic> data = {'personalcode': code};
    await insertData(data);
  }

Future<bool> checkPersonalCode(int code) async {
  final db = await database;
  final result = await db.query(tableName, where: 'personalcode = ?', whereArgs: [code]);

  return result.isNotEmpty;
}

}

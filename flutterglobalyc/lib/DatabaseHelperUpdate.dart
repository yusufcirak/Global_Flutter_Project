import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperUpdate {
  static final DatabaseHelperUpdate _instance = DatabaseHelperUpdate.internal();
  factory DatabaseHelperUpdate() => _instance;
  DatabaseHelperUpdate.internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'update_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE updateTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            softwareVersion TEXT,
            deviceSerialNumber TEXT,
            wifiSsid TEXT,
            wifiPass TEXT
          )
        ''');
      },
    );
  }

 
  Future<void> insertUpdate(Map<String, dynamic> data) async {
    final db = await database;
    List<Map> existingRecords = await db.query('updateTable');

    if (existingRecords.isNotEmpty) {
      await db.update('updateTable', data, where: 'id = ?', whereArgs: [existingRecords.first['id']]);
    } else {
      await db.insert('updateTable', data);
    }
  }
  // Bir kaydı güncellemek için
  Future<int> update(Map<String, dynamic> row) async {
    final db = await database;
    int id = row['id'];
    return await db.update('updateTable', row, where: 'id = ?', whereArgs: [id]);
  }

  // Bir kaydı silmek için
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('updateTable', where: 'id = ?', whereArgs: [id]);
  }

  // Tüm kayıtları getirmek için
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final db = await database;
    return await db.query('updateTable');
  }

  Future<void> insertOrUpdate(Map<String, dynamic> data) async {
  final db = await database;
  List<Map> existingRecords = await db.query('updateTable');

  if (existingRecords.isNotEmpty) {
    // Eğer kayıt varsa, mevcut kaydı güncelle
    await db.update('updateTable', data, where: 'id = ?', whereArgs: [existingRecords.first['id']]);
  } else {
    // Eğer kayıt yoksa, yeni bir kayıt ekle
    await db.insert('updateTable', data);
  }

  
}
Future<String> getSoftwareVersion() async {
    final db = await database;
    final result = await db.query('updateTable', columns: ['softwareVersion']);

    if (result.isNotEmpty) {
      return result.first['softwareVersion'] as String;
    } else {
      return 'Bilinmeyen Versiyon'; // Varsayılan değer veya hata mesajı
    }
  }


    Future<Map<String, String>> getWifiInfo() async {
    final db = await database;
    final result = await db.query(
      'updateTable',
      columns: ['wifiSsid', 'wifiPass'],
    );

    if (result.isNotEmpty) {
      return {
        'wifiSsid': result.first['wifiSsid'] as String,
        'wifiPass': result.first['wifiPass'] as String,
      };
    } else {
      return {'wifiSsid': 'Bilinmiyor', 'wifiPass': 'Bilinmiyor'}; // Varsayılan değerler veya hata mesajları
    }
  }
}

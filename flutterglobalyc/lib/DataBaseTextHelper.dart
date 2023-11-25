import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseTextHelper {
  static Database? _database;
  final String tableName = 'TextDataTable';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'TextData.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    final String createTableSql = '''
      CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
        FunctionName TEXT,
        FunctionHandpieceName TEXT,
        FunctionDescription TEXT,
        FunctionImage TEXT,
        FunctionVideo TEXT,
        FunctionText TEXT,
        FunctionText2 TEXT,
      )
    ''';
    await db.execute(createTableSql);
  }

  Future<int> insertTextData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> getAllTextData() async {
    final db = await database;
    return await db.query(tableName);
  }


  void main() async {
  // Veritabanını başlat
  final dbHelper = DataBaseTextHelper();
  await dbHelper._initDatabase(); // Bu sadece bir örnektir, normalde böyle kullanılmaz

  // Örnek veri
  Map<String, dynamic> sampleData = {
    
  };

  // Veriyi ekleyin
  int result = await dbHelper.insertTextData(sampleData);
  print('Eklenen verinin ID\'si: $result');

  // Tüm verileri alın
  List<Map<String, dynamic>> allData = await dbHelper.getAllTextData();
  print('Tüm veriler: $allData');
}





}

  
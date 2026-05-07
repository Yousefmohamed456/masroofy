import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends GetxService {
  static DatabaseHelper get instance => Get.find();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  /// Initialize database  in the default location for android
  Future<Database> initDb() async {
    // default  database location
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'masroofy_local.db');

    // Open Database
    return await openDatabase(path, version: 1, onCreate: _createSchema);
  }

  Future<void> _createSchema(Database db, int version) async {
    // Create Budget Cycles Table
    await db.execute('''
      CREATE TABLE budget_cycles(
        cycleId INTEGER PRIMARY KEY AUTOINCREMENT,
        totalAllowance REAL NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL
      )
    ''');

    // Create Transactions Table
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        cycleId INTEGER,
        FOREIGN KEY (cycleId) REFERENCES budget_cycles (cycleId) ON DELETE CASCADE
      )
    ''');

    // Create Categories Table
    await db.execute('''
    CREATE TABLE categories(
      categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      iconCode INTEGER NOT NULL
    )
  ''');

    // insertDefaultIcons
    final defaultCategories = [
      {'name': 'Food', 'iconCode': 0xe25a},
      {'name': 'Transport', 'iconCode': 0xe1d5},
      {'name': 'Entertainment', 'iconCode': 0xe3e0},
      {'name': 'Other', 'iconCode': 0xe14ea},
    ];

    for (var category in defaultCategories) {
      await db.insert('categories', category);
    }
  }

  /// Standard SQL Query with Arguments
  Future<List<Map<String, dynamic>>> executeQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    final db = await instance.database;
    return await db.rawQuery(sql, arguments);
  }

  /// Using insert is safer than a raw sql query since the built-in one is safe against SQL injection, returns number of changes made
  Future<int> insertSql(String table, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Uses the WHERE SQL Clause to update specific records, returns number of changes made
  Future<int> updateSql(
    String table,
    Map<String, dynamic> data,
    String whereColumn,
    dynamic whereArg,
  ) async {
    final db = await instance.database;
    return await db.update(
      table,
      data,
      where: '$whereColumn = ?',
      whereArgs: [whereArg],
    );
  }
}

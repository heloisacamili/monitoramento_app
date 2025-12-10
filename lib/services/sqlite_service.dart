import 'package:monitor_app/models/alert_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static final SqliteService instance = SqliteService._();
  SqliteService._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'alerts.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE alerts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            time TEXT
          )
        ''');
      },
    );
    return _db!;
  }

  Future<int> insert(AlertModel event) async {
    final db = await database;
    return db.insert('alerts', event.toMap());
  }

  Future<List<AlertModel>> getAll() async {
    final db = await database;
    final result = await db.query('alerts', orderBy: 'id DESC');
    return result.map(AlertModel.fromMap).toList();
  }
}

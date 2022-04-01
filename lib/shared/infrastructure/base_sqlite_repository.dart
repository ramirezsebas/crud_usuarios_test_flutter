import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseSqliteRepository {
  static final BaseSqliteRepository _instance =
      BaseSqliteRepository._internal();

  factory BaseSqliteRepository() => _instance;

  BaseSqliteRepository._internal() {
    _initDatabase();
  }

  //Database object
  late Database? _database;

  //Getter for the database

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Initialize the database
  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'test_itti_flutter.db');
    print("DB path: $path");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  //Create the table
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE usuarios(id TEXT PRIMARY KEY, nombre TEXT, fecha TEXT, sexo TEXT)',
    );
  }
}

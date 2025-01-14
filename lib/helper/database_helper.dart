import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String _bookDBName = 'bookDB';
  int _version = 1;

  static const bookTable = 'book';
  static const bookColumnId = '_bookId';
  static const bookColumnName = 'bookName';
  static const bookColumnDescription = 'bookDescription';
  static const bookColumnPrice = 'bookPrice';
  static const bookColumnQuantity = 'bookQYT';
  static const bookColumnIsAddedToBasket = 'bookBasket';
  static const bookColumnIsAddedToDone = 'bookDone';

  // static const shopBookTable = 'shopBook';
  // static const shopBookColumnId = '_shopBookId';
  // static const shopBookColumnName = 'shopBookName';
  // static const shopBookColumnPrice = 'shopBookPrice';
  // static const shopBookQuantity = 'shopBookQYT';

  DatabaseHelper._privateConstructor();

  static final instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _bookDBName);
    return await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $bookTable( 
          $bookColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $bookColumnName TEXT NOT NULL,
          $bookColumnDescription TEXT NOT NULL,
          $bookColumnPrice INTEGER NOT NULL,
          $bookColumnQuantity INTEGER,
          $bookColumnIsAddedToBasket INTEGER NOT NULL,
          $bookColumnIsAddedToDone INTEGER NOT NULL
          )
          ''',
        );

        // await db.execute(
        //   '''
        //   CREATE TABLE $shopBookTable(
        //   $shopBookColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        //   $shopBookColumnName TEXT NOT NULL,
        //   $shopBookColumnPrice INTEGER NOT NULL,
        //   $shopBookQuantity INTEGER NOT NULL
        //   )
        //   ''',
        // );
      },
    );
  }
}

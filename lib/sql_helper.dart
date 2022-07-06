import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    String createProductsTableQuery = '''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        barcode TEXT NOT NULL,
        name TEXT NOT NULL,
        imgUrl TEXT NOT NULL,
        imgSmallUrl TEXT NOT NULL,
        carboHydrates REAL NOT NULL,
        protein REAL NOT NULL,
        fat REAL NOT NULL,
        energyKj REAL NOT NULL,
        energyKcal REAL NOT NULL,
        vitaminA REAL NOT NULL,
        vitaminB1 REAL NOT NULL,
        vitaminB2 REAL NOT NULL,
        vitaminB6 REAL NOT NULL,
        vitaminB9 REAL NOT NULL,
        vitaminC REAL NOT NULL,
        vitaminD REAL NOT NULL,
        vitaminE REAL NOT NULL,
        vitaminK REAL NOT NULL,
        vitaminPP REAL NOT NULL,
      );
      ''';

    await database.execute(createProductsTableQuery);
  }

  static Future<sql.Database> db() async {
    final docDir = await getApplicationDocumentsDirectory();
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }

    String dbPath = p.join(docDir.path, 'myfitnesspal.db');

    return sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}

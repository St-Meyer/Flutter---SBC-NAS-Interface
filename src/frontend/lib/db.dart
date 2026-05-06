import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  
// Singleton Pattern - Damit die Datenbankverbindung nur einmal aufgebaut wird.

    static final Db _instance = Db._internal();

    factory Db() => _instance;

    Db._internal();

    late Database db;

                
    String modelquery = 'CREATE TABLE IF NOT EXISTS raspberry_models('
                        'id INTEGER Primary Key, '
                        'modelname TEXT, '
                        'rammodel TEXT, '
                        'idlepower REAL, '
                        'naspower REAL);';
    String settingquery = 'CREATE TABLE IF NOT EXISTS settings('
                            'id INTEGER Primary Key, '
                            'ip TEXT, '
                            'port TEXT, '
                            'kwhpreis REAL, '
                            'modelname TEXT, '
                            'FOREIGN KEY(modelname) '
                            'REFERENCES raspberry_models(modelname));';
    String seeddata = "";

    
    Future <Database> init() async {
        String dbPath = join(
            await getDatabasesPath(),
            "database.db");
        Database database = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
            await db.execute(modelquery);
            await db.execute(settingquery);
            await db.execute(seeddata);
            });
                return database;
    }
}
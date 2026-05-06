import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  
// Singleton Pattern - Damit die Datenbankverbindung nur einmal aufgebaut wird.

    static final Db _instance = Db._internal();

    factory Db() => _instance;

    Db._internal();

    late Database db;

                
    String modeltable = 'CREATE TABLE IF NOT EXISTS raspberry_models('
                        'id INTEGER Primary Key Autoincrement, '
                        'series_id INTEGER, '
                        'ram_id INTEGER, '
                        'idlepower REAL, '
                        'naspower REAL,'
                        'FOREIGN KEY (series_id)'
                        'REFERENCES raspberry_series(id),'
                        'FOREIGN KEY (ram_id) '
                        'REFERENCES ram_models(id));';

    String seriestable = 'CREATE TABLE IF NOT EXISTS raspberry_series('
                            'id INTEGER Primary Key Autoincrement, '
                            'seriesname TEXT)';

    String ramtable = 'CREATE TABLE IN NOT EXISTS ram_models('
                        'id INTEGER Primary Key Autoincrement, '
                        'ramsize text)';

    String settingstable = 'CREATE TABLE IF NOT EXISTS settings('
                            'id INTEGER Primary Key, '
                            'ip TEXT, '
                            'port TEXT, '
                            'kwhpreis REAL, '
                            'modelname TEXT, '
                            'FOREIGN KEY(modelname) '
                            'REFERENCES raspberry_models(modelname));';
                            
    String seeddataModel = 'INSERT INTO raspberry_models(modelname, '
                            'ram_id, '
                            'idlepower, '
                            'naspower)';

    
    Future <Database> init() async {
        String dbPath = join(
            await getDatabasesPath(),
            "database.db");
        Database database = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
            await db.execute(modeltable);
            await db.execute(settingstable);
            await db.execute(seeddataModel);
            });
                return database;
    }
}
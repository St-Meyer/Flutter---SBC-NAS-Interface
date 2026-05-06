import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  
// Singleton Pattern - Damit die Datenbankverbindung nur einmal aufgebaut wird.

    static final Db _instance = Db._internal();

    factory Db() => _instance;

    Db._internal();

    late Database db;

                
    String seriestable = 'CREATE TABLE IF NOT EXISTS raspberry_series('
                            'id INTEGER Primary Key Autoincrement, '
                            'seriesname TEXT)';

    String ramtable = 'CREATE TABLE IF NOT EXISTS ram_models('
                        'id INTEGER Primary Key Autoincrement, '
                        'ramsize text)';

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

    String settingstable = 'CREATE TABLE IF NOT EXISTS settings('
                            'id INTEGER Primary Key, '
                            'ip TEXT, '
                            'port TEXT, '
                            'kwhpreis REAL, '
                            'model_id INTEGER, '
                            'FOREIGN KEY(model_id) '
                            'REFERENCES raspberry_models(id));';

    String seeddataSeries = 'INSERT INTO raspberry_series('
                            'seriesname) VALUES'
                            '("Pi Zero 2 W"),'
                            '("Pi 3B+"),'
                            '("Pi 4B"),'
                            '("Pi 5");';

        String seeddataRam = 'INSERT INTO ram_models('
                            'ramsize) VALUES'
                            '("1GB"),'
                            '("2GB"),'
                            '("4GB"),'
                            '("8GB"),'
                            '("16GB");';

    
    Future <Database> init() async {
        String dbPath = join(
            await getDatabasesPath(),
            "database.db");
        Database database = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
            await db.execute(modeltable);
            await db.execute(settingstable);
            await db.execute(seeddataSeries);
            });
                return database;
    }
}
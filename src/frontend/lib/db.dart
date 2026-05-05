import 'package:sqflite/sqflite.dart';

class Db {
  
// Singleton Pattern - Damit die Datenbankverbindung nur einmal aufgebaut wird.

    static final Db _instance = Db._internal();

    factory Db() => _instance;

    Db._internal();

}
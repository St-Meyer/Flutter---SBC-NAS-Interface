import 'landing_page.dart';
import 'db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String ip = dotenv.env['IP_ADDRESS'].toString();
  String port = dotenv.env['PORT'].toString();


  // Datenbank-Initialisierung
  await Db().init();
  // IP und Port werden aus .env entnommen und in LandingPage
  // als Parameter weiter gegeben
  runApp(LandingPage(ip: ip, port: port));
}



Future <bool> checkSettings() async {
  var x = await Db().db.query('settings');
  if (x.isEmpty) {
    return true;
  }
  else {
    return false;
  }
}
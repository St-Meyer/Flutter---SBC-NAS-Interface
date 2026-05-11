import 'landing_page.dart';
import 'settings_page.dart';
import 'db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String ip = dotenv.env['IP_ADDRESS'].toString();
  String port = dotenv.env['PORT'].toString();


  // Datenbank-Initialisierung
  await Db().init();
  // IP und Port werden aus .env entnommen und in LandingPage
  // als Parameter weiter gegeben
  if (await checkSettings() == false) {
    runApp(LandingPage(ip: ip, port: port));
  }
  else {
    runApp(SettingsPage());
  }
  
}


// Überprüft, ob Einstellungen in DB bereits gespeichert sind.
Future <bool> checkSettings() async {
  var settingsCheck = await Db().db.query('settings');
  if (settingsCheck.isEmpty) {
    return true;
  }
  else {
    return false;
  }
}
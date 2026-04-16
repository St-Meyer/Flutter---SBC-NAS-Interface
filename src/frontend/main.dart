import 'connection.dart';
import 'api_reader.dart';
import 'landing_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String ip = dotenv.env['IP_ADDRESS'].toString();
  String port = dotenv.env['PORT'].toString();

  LandingPage(ip: ip, port: port);

  bool connectionDial = await connection.dial();

  if (connectionDial) {
    print("NAS connected");
  } else {
    print("Connection Failure");
  }

  runApp(const LandingPage());
}

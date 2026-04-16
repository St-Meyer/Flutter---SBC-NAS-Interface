import 'package:flutter/material.dart';
import 'connection.dart';
import 'api_reader.dart';
import 'main.dart';

class LandingPage extends StatefulWidget {
  String ip;
  String port;

  LandingPage({super.key, required this.ip, required this.port});

  var connection = Connection(ip, port);
  var apiReader = ApiReader(connection);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    const String appTitle = "SBC-NAS Interface";
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}

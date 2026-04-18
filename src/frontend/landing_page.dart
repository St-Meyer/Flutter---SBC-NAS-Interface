import 'package:flutter/material.dart';
import 'connection.dart';
import 'api_reader.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key, required this.ip, required this.port});
  final String ip;
  final String port;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Connection connection;
  late ApiReader apiReader;

  // Wird erstellt, wenn das Widget das 1. Mal erstellt wird.
  // Initialisiert connection und apiReader
  @override
  void initState() {
    super.initState();
    connection = Connection(widget.ip, widget.port);
    apiReader = ApiReader(connection);
  }

  // Baut Frontend Oberfläche
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

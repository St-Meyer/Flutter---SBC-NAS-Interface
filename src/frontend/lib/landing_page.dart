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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                  const Color.fromARGB(255, 47, 47, 47),
                  Colors.white
                ])),
          ),
          title: Text(appTitle),
          centerTitle: true,
          titleTextStyle: TextStyle(
              shadows: [Shadow(color: Colors.black, blurRadius: 4.0)],
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24),
        ),
        body: const Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}

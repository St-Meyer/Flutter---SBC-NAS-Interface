import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  // Controller, welche Texteingaben zwischen speichern.
  final ipController = TextEditingController();
  final portController = TextEditingController();
  final costController = TextEditingController();

  @override
  void dispose() {
    // Bereinigt den Controller, wenn das Widget verworfen wird.
    ipController.dispose();
    portController.dispose();
    costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String settingsTitle = "Settings";
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
                ]
              )
            ),
          ),
          title: Text(settingsTitle),
          centerTitle: true,
                    titleTextStyle: TextStyle(
              shadows: [Shadow(color: Colors.black, blurRadius: 4.0)],
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                color: Color.fromARGB(126, 163, 163, 163),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 16),
                      child: TextFormField(
                        controller: ipController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Gib die IP Adresse deines Raspberrys ein.'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 16),
                      child: TextFormField(
                        controller: portController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Gib den Port deines Raspberrys ein.'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 16),
                      child: TextFormField(
                        controller: costController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Kosten kWh in €'
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
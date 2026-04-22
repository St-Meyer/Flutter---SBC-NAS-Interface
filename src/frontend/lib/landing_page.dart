import 'dart:convert';

import 'package:flutter/material.dart';
import 'byte_container.dart';
import 'connection.dart';
import 'api_reader.dart';
import 'value_calculation.dart';

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
  double actualDiskUsage = 0.0;
  int completeDiskSpace = 0;
  int usedDiskSpace = 0;
  String completeDiskSpaceName = "";
  double completeDiskSpaceValue = 0.0;
  String usedDiskSpaceName = "";
  double usedDiskSpaceValue = 0.0;

  // Wird erstellt, wenn das Widget das 1. Mal erstellt wird.
  // Initialisiert connection und apiReader
  @override
  void initState() {
    super.initState();
    connection = Connection(widget.ip, widget.port);
    apiReader = ApiReader(connection);
    fetchDiskUsage();
  }

  void fetchDiskUsage() async {
    var value = await apiReader.readDiskUsage();
    Map decodedValue = jsonDecode(value);
    List listDiskUsage = decodedValue["disk_usage"];
    double diskPercent = listDiskUsage[3];
    int fetchedCompleteDiskSpace = listDiskUsage[0];
    int fetchedUsedDiskSpace = listDiskUsage[1];
    ByteContainer comDiskSpaceValue =
        ValueCalculation().convertBytes(fetchedCompleteDiskSpace);
    ByteContainer usDiskSpaceValue =
        ValueCalculation().convertBytes(fetchedUsedDiskSpace);

    setState(() {
      actualDiskUsage = diskPercent / 100;
      completeDiskSpaceValue = comDiskSpaceValue.value;
      completeDiskSpaceName = comDiskSpaceValue.byteName;
      usedDiskSpaceValue = usDiskSpaceValue.value;
      usedDiskSpaceName = usDiskSpaceValue.byteName;
    });
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
        body: Center(
          child: Column(
            children: <Widget>[
              const Text("Speicherbelegung"),
              LinearProgressIndicator(value: actualDiskUsage),
              Text((actualDiskUsage * 100).toString() + "%"),
              Text(usedDiskSpaceValue.toStringAsFixed(2) +
                  " " +
                  usedDiskSpaceName +
                  " / " +
                  completeDiskSpaceValue.toStringAsFixed(2) +
                  " " +
                  completeDiskSpaceName)
            ],
          ),
        ),
      ),
    );
  }
}

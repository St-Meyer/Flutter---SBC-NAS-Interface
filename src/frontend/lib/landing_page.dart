import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'byte_container.dart';
import 'connection.dart';
import 'api_reader.dart';
import 'value_calculation.dart';
import 'radial_gauge.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.ip, required this.port});
  final String ip;
  final String port;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Connection connection;
  late ApiReader apiReader;
  double actualDiskUsage = 0.0;
  double actualCpuPercents = 0.0;
  double actualRamPercents = 0.0;
  Duration actualBootTime = Duration.zero;
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
    fetchCpuPercents();
    fetchRamUsage();
    fetchBootTime();
    Timer.periodic(Duration(minutes: 1), (timer) {
      fetchDiskUsage();
      fetchBootTime();
    });
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchCpuPercents();
      fetchRamUsage();
    });
  }

  // API Aufruf, Festplattennutzung abzufangen.
  void fetchDiskUsage() async {
    var diskValue = await apiReader.readDiskUsage();
    Map decodedDiskValue = jsonDecode(diskValue);
    List listDiskUsage = decodedDiskValue["disk_usage"];
    double diskPercent = listDiskUsage[3];
    int fetchedCompleteDiskSpace = listDiskUsage[0];
    int fetchedUsedDiskSpace = listDiskUsage[1];
    ByteContainer comDiskSpaceValue =
        ValueCalculation().convertBytes(fetchedCompleteDiskSpace);
    ByteContainer usDiskSpaceValue =
        ValueCalculation().convertBytes(fetchedUsedDiskSpace);

    // Ändert die Werte in der UI
    setState(() {
      actualDiskUsage = diskPercent;
      completeDiskSpaceValue = comDiskSpaceValue.value;
      completeDiskSpaceName = comDiskSpaceValue.byteName;
      usedDiskSpaceValue = usDiskSpaceValue.value;
      usedDiskSpaceName = usDiskSpaceValue.byteName;
    });
  }

  // API Aufruf, CPU Belastung in Prozenten abzufangen.
  void fetchCpuPercents() async {
    var cpuValue = await apiReader.readCpuPercents();
    Map decodedCpuValue = jsonDecode(cpuValue);
    List listCpuUsage = decodedCpuValue["cpu_percents"];
    double temp = 0;
    for (int i = 0; i < listCpuUsage.length; i++) {
      temp += listCpuUsage[i];
    }

    setState(() {
      actualCpuPercents = temp / listCpuUsage.length;
    });
  }

// API Aufruf, RAM Belastung in Prozenten abzufangen.
  void fetchRamUsage() async {
    var ramValue = await apiReader.readRamUsage();
    Map decodedRamValue = jsonDecode(ramValue);
    List listRamUsage = decodedRamValue["ram_usage"];
    double fetchedRamPercents = listRamUsage[2];

    setState(() {
      actualRamPercents = fetchedRamPercents;
    });
  }

  void fetchBootTime() async {
    var bootTimeValue = await apiReader.readBootTime();
    Map decodedBootTimeValue = jsonDecode(bootTimeValue);
    double fetchedBootTime = decodedBootTimeValue["boottime"];

    setState(() {
      actualBootTime = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(fetchedBootTime.toInt() * 1000));
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
                  ]
                )
            ),
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
            mainAxisSize: MainAxisSize.max,
              children:<Widget>[
                Card(
                  color: Color.fromARGB(126, 163, 163, 163),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("Speicherbelegung"),
                      LinearProgressIndicator(value: actualDiskUsage/100, minHeight: 20,),
                      Text("$actualDiskUsage %"),
                      Text(
                        "${usedDiskSpaceValue.toStringAsFixed(2)} $usedDiskSpaceName / ${completeDiskSpaceValue.toStringAsFixed(2)} $completeDiskSpaceName")
                      ],
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(126, 163, 163, 163),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text("CPU-Belastung"),
                              RadialGaugeWidget(value: actualCpuPercents),
                              Text("${actualCpuPercents.toStringAsFixed(2)}%")
                            ],
                          )
                        ),
                      ),
                      Expanded(
                        child:Card(
                          color: Color.fromARGB(126, 163, 163, 163),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text("RAM-Belastung"),
                              RadialGaugeWidget(value: actualRamPercents),
                              Text("${(actualRamPercents.toStringAsFixed(2))}%")
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(126, 163, 163, 163),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Betriebszeit"),
                              Text("${actualBootTime.inHours}h ${actualBootTime.inMinutes % 60}min")
                            ]
                          )
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(126, 163, 163, 163),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Betriebskosten"),
                            ],
                          ),
                      ))
                    ],
                  )
                ),
              ] 
            ),
        ),
      ),
    );
  }
}

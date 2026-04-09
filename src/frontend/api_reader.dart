import 'dart:math';

import 'connection.dart';

class ApiReader {
  Connection connection;

  ApiReader(this.connection);

  Future<String> readCpuPercents() async {
    return await connection.apiResponse("/cpu_percents");
  }

  Future<String> readCpuFrequency() async {
    return await connection.apiResponse("/cpu_frequency");
  }

  Future<String> readCpuTemperatures() async {
    return await connection.apiResponse("/cpu_temperatures");
  }

  Future<String> readRamUsage() async {
    return await connection.apiResponse("/ram_usage");
  }

  Future<String> readDiskUsage() async {
    return await connection.apiResponse("/disk_usage");
  }

  Future<String> readDiskIO() async {
    return await connection.apiResponse("/disk_io");
  }

  Future<String> readNetworkIO() async {
    return await connection.apiResponse("/network_io");
  }

  Future<String> readActiveNetwork() async {
    return await connection.apiResponse("/active_network");
  }

  Future<String> readBootTime() async {
    return await connection.apiResponse("/boottime");
  }

  Future<String> readRunnungProcesses() async {
    return await connection.apiResponse("/running_processes");
  }
}

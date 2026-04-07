import 'connection.dart';

class ApiReader {
  Connection connection;

  ApiReader(this.connection);

  Future<String> readCpuPercents() async {
    return await connection.apiResponse("/cpu_percents");
  }
}

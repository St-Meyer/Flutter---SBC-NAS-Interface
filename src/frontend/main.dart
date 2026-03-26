import 'connection.dart';

void main() async {
  String ip = "192.168.0.33";
  String port = "8080";
  var connection = Connection(ip, port);
  bool connectionDial = await connection.dial();
}

import 'connection.dart';

void main() async {
  //String ip = "192.168.0.33";
  String ip = "127.0.0.1";
  String port = "8000";
  var connection = Connection(ip, port);
  bool connectionDial = await connection.dial();

  if (connectionDial) {
    print("NAS connected");
  } else {
    print("Connection Failure");
  }
}

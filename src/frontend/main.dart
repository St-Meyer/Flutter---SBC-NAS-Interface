import 'connection.dart';
import 'api_reader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String ip = dotenv.env['IP_ADDRESS'].toString();
  String port = dotenv.env['PORT'].toString();
  var connection = Connection(ip, port);
  var apiReader = ApiReader(connection);
  bool connectionDial = await connection.dial();

  if (connectionDial) {
    print("NAS connected");
  } else {
    print("Connection Failure");
  }
}

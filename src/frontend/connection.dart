import 'dart:io';

class Connection {
  // Deklaration
  String ip;
  String port;

  // Konstruktor
  Connection(this.ip, this.port);

  // Methode für Verbindungsaufbau, Bool-Ausgabe ob gelungen oder nicht
  Future<bool> dial() async {
    var client = HttpClient();
    try {
      var request = await client.getUrl(Uri.parse("http://" + ip + ":" + port));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Connection Error: " + e.toString());
      return false;
    }
  }
}

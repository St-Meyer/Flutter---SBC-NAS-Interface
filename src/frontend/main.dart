import 'dart:io';

void main() async {
  var client = HttpClient();
  var request = await client.getUrl(Uri.parse('http://192.168.0.33:8080'));
  var response = await request.close();

  if (response.statusCode == HttpStatus.ok) {
    print("Response code successful");
  }
  else {
    print("Failure");
  }
}
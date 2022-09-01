import 'package:http/http.dart' as http;

Future<void> sendNotification() async {
  final response = await http.post(Uri.parse('http://10.0.2.2:8080/notify'));
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to make request');
  }
}

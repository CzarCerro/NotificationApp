import 'package:http/http.dart' as http;

Future<void> sendNotification(String token) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/notify/' + token),
  );
  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to make request');
  }
}

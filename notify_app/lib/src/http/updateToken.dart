import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> updateToken(String token, String status) async {
  final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/tokens'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'token': token,
      'status': status,
    }),

  );
  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to make request');
  }
}

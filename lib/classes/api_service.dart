import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://7771-35-197-37-105.ngrok-free.app"; // Use the correct API URL

  Future<Map<String, dynamic>> fetchQuizData(String rightName) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'type': rightName}),
      );

      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.isEmpty) {
          throw Exception('Empty response from the server');
        }
        return json.decode(responseBody);
      } else {
        throw Exception('Failed to load quiz data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching quiz data: $e');
    }
  }
}
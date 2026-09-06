import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseURL = 'https://my-notes-psi-snowy.vercel.app/api';

  Future<List<dynamic>> getNotesData() async {
    try {
      final res = await http.get(Uri.parse('$baseURL/getNotes'));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        return decoded["data"];
      } else {
       throw Exception(
          "Failed to load Notes data: ${res.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }


  // login
Future<Map<String, dynamic>> loginApi(
  String email,
  String password,
) async {
  try {
    final res = await http.post(
      Uri.parse('$baseURL/login'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);

      return decoded;
    } else {
      throw Exception(
        'Login failed: ${res.statusCode}',
      );
    }
  } catch (e) {
    throw Exception('Login error: $e');
  }
}
}

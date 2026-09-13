import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseURL = 'https://my-notes-psi-snowy.vercel.app/api';

  // get notes

  Future<List<dynamic>> getNotesData() async {
    try {
      final res = await http.get(Uri.parse('$baseURL/getNotes'));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        return decoded["data"];
      } else {
        throw Exception("Failed to load Notes data: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  // login
  Future<Map<String, dynamic>> loginApi(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseURL/login'),

        headers: {'Content-Type': 'application/json'},

        body: jsonEncode({'email': email, 'password': password}),
      );

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        return decoded;
      } else {
        throw Exception('Login failed: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // Register
  Future<Map<String, dynamic>> RegisterAPI(
    String firstname,
    String lastname,
    String email,
    String password,
  ) async {
    try {
      final res = await http.post(
        Uri.parse('$baseURL/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
        }),
      );

      print("Register Status: ${res.statusCode}");
      print("Register Response: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        final decoded = jsonDecode(res.body);
        return decoded;
      } else {
        throw Exception('Register failed: ${res.statusCode}\n${res.body}');
      }
    } catch (e) {
      throw Exception('Register error: $e');
    }
  }
// Add Topic
Future<Map<String, dynamic>> addTopicAPI(
  String name,
  String description,
  String coverImage,
  String status,
) async {
  try {
    final res = await http.post(
      Uri.parse('$baseURL/topics'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'coverImage': coverImage,
        'status': status,
      }),
    );

    print("Topic Status: ${res.statusCode}");
    print("Topic Response: ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      final decoded = jsonDecode(res.body);

      return decoded;
    } else {
      throw Exception(
        'Topic add failed: ${res.statusCode}\n${res.body}',
      );
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
  // getTopic

  Future<List<dynamic>> getTopicsAPI() async {
    try {
      final res = await http.get(Uri.parse('$baseURL/getTopic'));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        return decoded["data"];
      } else {
        throw Exception("Failed to load Topics data: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // get User

  Future<List<dynamic>> getUserAPI() async {
    try {
      final res = await http.get(Uri.parse('$baseURL/user'));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        return decoded["data"];
      } else {
        throw Exception("Failed to load Usre data: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

import 'dart:convert';
import 'dart:io';
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
// // Add Topic
// Future<Map<String, dynamic>> addTopicAPI(
//   String name,
//   String description,
//   String coverImage,
//   String status,
// ) async {
//   try {
//     final res = await http.post(
//       Uri.parse('$baseURL/topics'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'name': name,
//         'description': description,
//         'coverImage': coverImage,
//         'status': status,
//       }),
//     );

//     print("Topic Status: ${res.statusCode}");
//     print("Topic Response: ${res.body}");

//     if (res.statusCode == 200 || res.statusCode == 201) {
//       final decoded = jsonDecode(res.body);

//       return decoded;
//     } else {
//       throw Exception(
//         'Topic add failed: ${res.statusCode}\n${res.body}',
//       );
//     }
//   } catch (e) {
//     throw Exception("Error: $e");
//   }
// }




// Future<Map<String, dynamic>> addTopicAPI({
//   required String name,
//   required String description,
//   required String status,
//   String? imageUrl,
//   File? imageFile,
// }) async {
//   final uri = Uri.parse("$baseURL/topics");

//   final request = http.MultipartRequest(
//     "POST",
//     uri,
//   );

//   request.fields["name"] = name;
//   request.fields["description"] = description;
//   request.fields["status"] = status;

//   // URL option
//   if (imageFile == null &&
//       imageUrl != null &&
//       imageUrl.trim().isNotEmpty) {
//     request.fields["coverImageUrl"] = imageUrl.trim();
//   }

//   // Gallery file option
//   if (imageFile != null) {
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         "coverImage",
//         imageFile.path,
//       ),
//     );
//   }

//   final streamedResponse = await request.send();

//   final response = await http.Response.fromStream(
//     streamedResponse,
//   );

//   final data = jsonDecode(response.body);

//   if (response.statusCode >= 200 &&
//       response.statusCode < 300) {
//     return data;
//   }

//   throw Exception(
//     data["message"] ?? "Failed to add topic",
//   );
// }







Future<Map<String, dynamic>> addTopicAPI({
  required String name,
  required String description,
  required String status,
  String? imageUrl,
  File? imageFile,
}) async {
  final uri = Uri.parse("$baseURL/topics");

  final request = http.MultipartRequest(
    "POST",
    uri,
  );

  request.fields["name"] = name;
  request.fields["description"] = description;
  request.fields["status"] = status.toLowerCase();

  // URL option
  if (imageFile == null &&
      imageUrl != null &&
      imageUrl.trim().isNotEmpty) {
    request.fields["coverImageUrl"] = imageUrl.trim();
  }

  // Gallery file option
  if (imageFile != null) {
    request.files.add(
      await http.MultipartFile.fromPath(
        "coverImage",
        imageFile.path,
      ),
    );
  }

  final streamedResponse = await request.send();

  final response = await http.Response.fromStream(
    streamedResponse,
  );

  // Debugging
  print("STATUS CODE: ${response.statusCode}");
  print("RESPONSE BODY: ${response.body}");

  // Success response
  if (response.statusCode >= 200 &&
      response.statusCode < 300) {
    try {
      final data = jsonDecode(response.body);

      return Map<String, dynamic>.from(data);
    } catch (e) {
      throw Exception(
        "Invalid JSON response: ${response.body}",
      );
    }
  }

  // Error response
  String errorMessage;

  try {
    final errorData = jsonDecode(response.body);

    errorMessage = errorData["message"]?.toString() ??
        "Failed to add topic";
  } catch (e) {
    errorMessage = response.body.isNotEmpty
        ? response.body
        : "Server error occurred";
  }

  throw Exception(
    "Error ${response.statusCode}: $errorMessage",
  );
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

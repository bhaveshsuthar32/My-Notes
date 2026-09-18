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




  // add notes



  // // Add Notes API
  // Future<Map<String, dynamic>> addNotesAPI({
  //   required String title,
  //   required String subtitle,
  //   required String content,
  //   required int topicId,
  //   required String status,
  //   List<File> images = const [],
  // }) async {
  //   final Uri uri = Uri.parse("$baseURL/notes");

  //   final http.MultipartRequest request =
  //       http.MultipartRequest(
  //     "POST",
  //     uri,
  //   );

  //   // Text fields
  //   request.fields["title"] = title;
  //   request.fields["subtitle"] = subtitle;
  //   request.fields["content"] = content;
  //   request.fields["topicId"] = topicId.toString();
  //   request.fields["status"] = status.toLowerCase();

  //   // Multiple images
  //   for (final File image in images) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         "images",
  //         image.path,
  //       ),
  //     );
  //   }

  //   final streamedResponse = await request.send();

  //   final http.Response response =
  //       await http.Response.fromStream(
  //     streamedResponse,
  //   );

  //   print("STATUS CODE: ${response.statusCode}");
  //   print("RESPONSE BODY: ${response.body}");

  //   if (response.statusCode >= 200 &&
  //       response.statusCode < 300) {
  //     try {
  //       final dynamic decodedData =
  //           jsonDecode(response.body);

  //       return Map<String, dynamic>.from(decodedData);
  //     } catch (error) {
  //       throw Exception(
  //         "Invalid JSON response: ${response.body}",
  //       );
  //     }
  //   }

  //   String errorMessage;

  //   try {
  //     final dynamic decodedError =
  //         jsonDecode(response.body);

  //     errorMessage =
  //         decodedError["message"]?.toString() ??
  //             "Failed to create note";
  //   } catch (error) {
  //     errorMessage = response.body.isNotEmpty
  //         ? response.body
  //         : "Server error occurred";
  //   }

  //   throw Exception(
  //     "Error ${response.statusCode}: $errorMessage",
  //   );
  // }



// // Add Notes API
// Future<Map<String, dynamic>> addNotesAPI({
//   required String title,
//   required String subtitle,
//   required String content,
//   required int topicid,
//   required String status,
//   List<File> images = const [],
//   List<String> imageUrls = const []
//   ,
// }) async {
//   final Uri uri = Uri.parse("$baseURL/notes");

//   final http.MultipartRequest request = http.MultipartRequest(
//     "POST",
//     uri,
//   );

//   // Text fields
//   request.fields["title"] = title;
//   request.fields["subtitle"] = subtitle;
//   request.fields["content"] = content;
//   request.fields["topicid"] = topicid.toString();
//   request.fields["status"] = status.toLowerCase();

//   // Image URLs send as JSON string
//   if (imageUrls.isNotEmpty) {
//     request.fields["imageUrls"] = jsonEncode(imageUrls);
//   }

//   // Multiple gallery images
//   for (final File image in images) {
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         "images",
//         image.path,
//       ),
//     );
//   }

//   final streamedResponse = await request.send();

//   final http.Response response = await http.Response.fromStream(
//     streamedResponse,
//   );

//   print("STATUS CODE: ${response.statusCode}");
//   print("RESPONSE BODY: ${response.body}");

//   if (response.statusCode >= 200 &&
//       response.statusCode < 300) {
//     try {
//       final dynamic decodedData = jsonDecode(response.body);

//       return Map<String, dynamic>.from(decodedData);
//     } catch (error) {
//       throw Exception(
//         "Invalid JSON response: ${response.body}",
//       );
//     }
//   }

//   String errorMessage;

//   try {
//     final dynamic decodedError = jsonDecode(response.body);

//     errorMessage = decodedError["message"]?.toString() ??
//         "Failed to create note";
//   } catch (error) {
//     errorMessage = response.body.isNotEmpty
//         ? response.body
//         : "Server error occurred";
//   }

//   throw Exception(
//     "Error ${response.statusCode}: $errorMessage",
//   );
// }


// create notes

// Add Notes API
Future<Map<String, dynamic>> addNotesAPI({
  required String title,
  required int topicid,
  required String status,

  required List<Map<String, dynamic>> subtitles,
  required List<Map<String, dynamic>> contents,
  required List<Map<String, dynamic>> images,
  required List<Map<String, dynamic>> contentOrder,

  List<File> imageFiles = const [],
}) async {
  final Uri uri = Uri.parse("$baseURL/notes");

  final http.MultipartRequest request =
      http.MultipartRequest(
    "POST",
    uri,
  );

  // ============================================================
  // FIXED FIELDS
  // ============================================================

  request.fields["title"] = title;
  request.fields["topicid"] = topicid.toString();
  request.fields["status"] = status.toLowerCase();

  // ============================================================
  // DYNAMIC CONTENT
  // ============================================================

  request.fields["subtitle"] =
      jsonEncode(subtitles);

  request.fields["content"] =
      jsonEncode(contents);

  request.fields["images"] =
      jsonEncode(
    images,
  );

  request.fields["contentOrder"] =
      jsonEncode(
    contentOrder,
  );

  // ============================================================
  // IMAGE FILES
  // ============================================================

  for (final File image in imageFiles) {
    request.files.add(
      await http.MultipartFile.fromPath(
        "images",
        image.path,
      ),
    );
  }

  // ============================================================
  // SEND REQUEST
  // ============================================================

  final streamedResponse =
      await request.send();

  final http.Response response =
      await http.Response.fromStream(
    streamedResponse,
  );

  print(
    "STATUS CODE: ${response.statusCode}",
  );

  print(
    "RESPONSE BODY: ${response.body}",
  );

  // ============================================================
  // SUCCESS
  // ============================================================

  if (response.statusCode >= 200 &&
      response.statusCode < 300) {
    try {
      final dynamic decodedData =
          jsonDecode(
        response.body,
      );

      return Map<String, dynamic>.from(
        decodedData,
      );
    } catch (error) {
      throw Exception(
        "Invalid JSON response: ${response.body}",
      );
    }
  }

  // ============================================================
  // ERROR
  // ============================================================

  String errorMessage;

  try {
    final dynamic decodedError =
        jsonDecode(
      response.body,
    );

    errorMessage =
        decodedError["message"]?.toString() ??
            "Failed to create note";
  } catch (error) {
    errorMessage =
        response.body.isNotEmpty
            ? response.body
            : "Server error occurred";
  }

  throw Exception(
    "Error ${response.statusCode}: $errorMessage",
  );
}

}

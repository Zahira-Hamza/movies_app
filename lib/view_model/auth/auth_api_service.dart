import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/data/models/auth/reset_password_data.dart';

class AuthApiService {
  Future<String> resetPassword(
      {required ResetPasswordData data, required String token}) async {
    final uri =
        Uri.https(ApiConstants.authBaseUrl, ApiConstants.resetPasswordEndPoint);

    final response = await http.patch(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['message'] ?? 'password Updated !';
    } else {
      final jsonResponse = jsonDecode(response.body);

      throw Exception(
          'Failed to update profile: ${jsonResponse['message'] ?? 'Unknown error'}');
    }
  }
}

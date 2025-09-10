// import 'dart:convert';
// import 'package:movies_app/core/constants/api_constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:movies_app/data/models/user/update_user_profile_request.dart';

// class ProfileApiService {
//   Future<String> updateData({
//     required UpdateUserProfileRequest profile,
//     required String token,
//   }) async {
//     Uri uri = Uri.https(ApiConstants.authBaseUrl, ApiConstants.profileEndPoint);
//     final response = await http.patch(uri,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(profile.toJson()));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final jsonResponse = jsonDecode(response.body);

//       return jsonResponse['message'] ?? 'Profile updated successfully';
//     } else {
//       final jsonResponse = jsonDecode(response.body);

//       throw Exception(
//           'Failed to update profile: ${jsonResponse['message'] ?? 'Unknown error'}');
//     }
//   }

//   Future<String> deleteAccount({required String token}) async {
//     Uri uri = Uri.https(ApiConstants.authBaseUrl, ApiConstants.profileEndPoint);
//     final response = await http.delete(
//       uri,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       return jsonResponse['message'] ?? 'Profile deleted successfully';
//     } else {
//       final jsonResponse = jsonDecode(response.body);

//       throw Exception(
//           'Failed to Delete Account: ${jsonResponse['message'] ?? 'Unknown error'}');
//     }
//   }
// }

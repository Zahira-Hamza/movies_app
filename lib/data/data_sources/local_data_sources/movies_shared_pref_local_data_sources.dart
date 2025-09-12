import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/core/constants/errors/app_exception.dart';
import 'package:movies_app/data/models/movies/movies_model.dart';

class MoviesSharedPrefLocalDataSources {
  static const String _cacheKey = "cached_movies";

  Future<void> cacheMovies(List<MoviesModel> movies) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonMovies = movies.map((m) => m.toJson()).toList();
      await prefs.setString(_cacheKey, jsonEncode(jsonMovies));
    } catch (e) {
      throw ApiException("Failed to cache movies: $e");
    }
  }

  Future<List<MoviesModel>> getCachedMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_cacheKey);

      if (jsonString == null) return [];

      final List decoded = jsonDecode(jsonString);
      return decoded
          .map((m) => MoviesModel.fromJson(m as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ApiException("Failed to load cached movies: $e");
    }
  }
}

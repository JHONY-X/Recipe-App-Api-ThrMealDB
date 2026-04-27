import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/meal.dart';
import '../models/meal_category.dart';
import 'api_exception.dart';
import 'cache_manager.dart';
import 'api_response.dart';

class MealApiService {
  final String _baseUrl = 'www.themealdb.com';
  final Duration _timeout = const Duration(seconds: 10);
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  final CacheManager _cache = CacheManager();

  void _checkResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Server error: ${response.reasonPhrase}',
      );
    }
  }

  Stream<ApiResponse<List<MealCategory>>> fetchCategoriesStream() async* {
    final cacheKey = 'categories';
    final cachedData = _cache.get<List<MealCategory>>(cacheKey);

    if (cachedData != null) {
      yield ApiResponse(data: cachedData, isFromCache: true);
    }

    try {
      final freshData = await fetchCategories();
      _cache.save(cacheKey, freshData);
      yield ApiResponse(data: freshData, isFromCache: false);
    } catch (e) {
      if (cachedData == null) rethrow;
    }
  }

  Future<List<MealCategory>> fetchCategories() async {
    try {
      final uri = Uri.https(_baseUrl, '/api/json/v1/1/categories.php');
      final response = await http
          .get(uri, headers: _headers)
          .timeout(_timeout);

      _checkResponse(response);

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> categoriesJson = data['categories'] ?? [];

      return categoriesJson
          .map((json) => MealCategory.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } on FormatException {
      throw Exception('Unexpected data format received');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Stream<ApiResponse<List<Meal>>> fetchMealsByCategoryStream(String category) async* {
    final cacheKey = 'meals_$category';
    final cachedData = _cache.get<List<Meal>>(cacheKey);

    if (cachedData != null) {
      yield ApiResponse(data: cachedData, isFromCache: true);
    }

    try {
      final freshData = await fetchMealsByCategory(category);
      _cache.save(cacheKey, freshData);
      yield ApiResponse(data: freshData, isFromCache: false);
    } catch (e) {
      if (cachedData == null) rethrow;
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    try {
      final uri = Uri.https(_baseUrl, '/api/json/v1/1/filter.php', {'c': category});
      final response = await http
          .get(uri, headers: _headers)
          .timeout(_timeout);

      _checkResponse(response);

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      return mealsJson
          .map((json) => Meal.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } on FormatException {
      throw Exception('Unexpected data format received');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Meal> fetchMealDetails(String mealId) async {
    final cacheKey = 'meal_details_$mealId';
    final cachedData = _cache.get<Meal>(cacheKey);
    if (cachedData != null) return cachedData;

    try {
      final uri = Uri.https(_baseUrl, '/api/json/v1/1/lookup.php', {'i': mealId});
      final response = await http
          .get(uri, headers: _headers)
          .timeout(_timeout);

      _checkResponse(response);

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      if (mealsJson.isEmpty) {
        throw Exception('Meal not found');
      }

      final meal = Meal.fromJson(mealsJson.first as Map<String, dynamic>);
      _cache.save(cacheKey, meal);
      return meal;
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } on FormatException {
      throw Exception('Unexpected data format received');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<List<Meal>> searchMealsByName(String query) async {
    try {
      final uri = Uri.https(_baseUrl, '/api/json/v1/1/search.php', {'s': query});
      final response = await http
          .get(uri, headers: _headers)
          .timeout(_timeout);

      _checkResponse(response);

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];

      return mealsJson
          .map((json) => Meal.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } on FormatException {
      throw Exception('Unexpected data format received');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

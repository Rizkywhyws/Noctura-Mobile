import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../visualization/prediction_stats.dart';
import '../config/api_config.dart';

class ApiService {
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<PredictionStats> getPredictionStats() async {
    try {
      final token = await _getToken();
      
      final url = Uri.parse('${ApiConfig.baseUrl}/mobile-chart-data');
      
      print('Requesting: $url');
      
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      
      print('Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          return PredictionStats.fromJson(json);
        } else {
          throw Exception(json['message'] ?? 'Failed to load data');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Silakan login ulang');
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Network error: $e');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class EdukasiService {
  static const String baseUrl = '${ApiConfig.baseUrl}/edukasi';

  static Future<List<dynamic>> getEdukasi({bool onlyPublished = true}) async {
    try {
      final url = onlyPublished ? '$baseUrl/published' : baseUrl;
      print('📡 Panggil API: $url');
      
      final response = await http.get(Uri.parse(url));
      
      print('📡 Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('📡 Data diterima: ${data['data']?.length ?? 0} item');
        return data['data'] ?? [];
      } else {
        print('❌ Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Exception: $e');
      return [];
    }
  }
}
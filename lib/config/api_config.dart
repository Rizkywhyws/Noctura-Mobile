class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api',
  );

  static String get storageUrl => baseUrl.replaceAll('/api', '/storage');

  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    final fileName = path.contains('/') ? path.split('/').last : path;
    return '$storageUrl/edukasi/$fileName';
  }
}
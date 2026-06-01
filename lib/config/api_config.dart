class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.84.188.66:8000/api',
  );

  static String get storageUrl => baseUrl.replaceAll('/api', '/storage');

 static String getImageUrl(String? path) {
  if (path == null || path.isEmpty) return '';
  if (path.startsWith('http')) return path;

  final cleanPath = path.replaceFirst(RegExp(r'^/storage/'), '');
  return '$storageUrl/$cleanPath';
}
}
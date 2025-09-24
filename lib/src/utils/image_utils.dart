import '../core/api/api_resources.dart' show ApiResources;

class ImageUtils {
  /// Build a fully qualified image URL from a possibly relative path.
  /// - If [path] is null/empty, returns empty string
  /// - If [path] already starts with http/https, returns as-is
  /// - Else, prefixes with the API host (without the trailing /api)
  static String buildImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    final lower = path.toLowerCase();
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return path;
    }
    // ApiResources.baseUrl contains '/api' suffix. Remove it for static files host
    var base = ApiResources.baseUrl;
    if (base.endsWith('/')) base = base.substring(0, base.length - 1);
    if (base.endsWith('/api')) base = base.substring(0, base.length - 4);
    // Ensure leading slash on path
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return '$base$normalizedPath';
  }
}



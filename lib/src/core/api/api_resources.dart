import 'dart:io';

import 'package:dio/dio.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';
import '../services/preferences_service.dart' show PreferencesServices;
import 'api_routes.dart' show ApiRoutes;

class ApiResources {
  static final String baseUrl = ApiRoutes.baseUrl;

  static final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    ),
  );

  /// Initialise Dio avec le token Laravel (si dispo)
  static Future<void> initialize() async {
    try {
      if (PreferencesServices.hasData(PreferencesServices.apiTokenKey)) {
        final token =
            PreferencesServices.getValue(PreferencesServices.apiTokenKey);
        if (token != null) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        }
        AppLogger.instance.logger.i(
            'API Token: ${PreferencesServices.getValue(PreferencesServices.apiTokenKey)} \n headers: ${_dio.options.headers}');
      } else {
        AppLogger.instance.logger
            .i('API Token non trouvé => ${_dio.options.headers}');
      }
    } catch (e) {
      AppLogger.instance.logger.e(e);
    }
  }

  /// Définir le token manuellement (après login)
  static Future<void> setToken(String token) async {
    await PreferencesServices.registerValue(
        PreferencesServices.apiTokenKey, token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Nettoyer le token (ex: logout)
  static Future<void> clearToken() async {
    await PreferencesServices.deleteValue(PreferencesServices.apiTokenKey);
    _dio.options.headers.remove('Authorization');
  }

  /// Méthode GET générique
  static Future<Response> get(String path,
      {Map<String, dynamic>? query}) async {
    await initialize();
    return await _dio.get(path, queryParameters: query);
  }

  /// Méthode POST générique
  static Future<Response> post(String path,
      {Map<String, dynamic>? data, bool isFormData = false}) async {
    await initialize();

    if (data == null) {
      return await _dio.post(path);
    }

    // Vérifie si au moins une valeur est un fichier
    final containsFile =
        data.values.any((v) => v is File || v is MultipartFile);
    if (isFormData || containsFile) {
      final formData = FormData();

      for (var entry in data.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is File) {
          formData.files.add(
            MapEntry(
              key,
              await MultipartFile.fromFile(
                value.path,
                filename: value.uri.pathSegments.last,
              ),
            ),
          );
        } else if (value is MultipartFile) {
          formData.files.add(MapEntry(key, value));
        } else if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      }

      return await _dio.post(path, data: formData);
    }

    return await _dio.post(path, data: data);
  }

  /// Méthode PUT générique
  static Future<Response> put(String path,
      {Map<String, dynamic>? data, bool isFormData = false}) async {
    await initialize();

    if (data == null) {
      return await _dio.post(path);
    }

    // Vérifie si au moins une valeur est un fichier
    final containsFile =
        data.values.any((v) => v is File || v is MultipartFile);
    if (isFormData || containsFile) {
      final formData = FormData();

      for (var entry in data.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is File) {
          formData.files.add(
            MapEntry(
              key,
              await MultipartFile.fromFile(
                value.path,
                filename: value.uri.pathSegments.last,
              ),
            ),
          );
        } else if (value is MultipartFile) {
          formData.files.add(MapEntry(key, value));
        } else if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      }

      return await _dio.put(path, data: formData);
    }

    return await _dio.put(path, data: data);
  }

  /// Méthode DELETE générique
  static Future<Response> delete(String path,
      {Map<String, dynamic>? data}) async {
    await initialize();
    return await _dio.delete(path, data: data);
  }

  /// Accès direct à Dio (si besoin)
  static Dio get client => _dio;
}

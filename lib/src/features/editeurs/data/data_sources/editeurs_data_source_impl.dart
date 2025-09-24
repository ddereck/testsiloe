import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/editeur_model.dart';
import 'editeurs_data_source.dart';
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/services/preferences_service.dart' show PreferencesServices;

class EditeursDataSourceImpl implements EditeursDataSource {
  final http.Client httpClient;

  EditeursDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<List<EditeurModel>> getEditeurs() async {
    try {
      final token = PreferencesServices.getValue(PreferencesServices.apiTokenKey) as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token API non disponible');
      }

      final response = await httpClient.get(
        Uri.parse('${ApiResources.baseUrl}/utilisateurs/editeurs'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return [];
        }

        try {
          final dynamic decoded = json.decode(response.body);
          if (decoded is List) {
            return decoded.map((e) => EditeurModel.fromJson(e as Map<String, dynamic>)).toList();
          }
          if (decoded is Map<String, dynamic>) {
            // Support pagination envelope: { "data": [ ... ] }
            final dynamic data = decoded['data'];
            if (data is List) {
              return data.map((e) => EditeurModel.fromJson(e as Map<String, dynamic>)).toList();
            }
            // If no data list, fallback to empty
            return [];
          }
          return [];
        } catch (jsonError) {
          throw Exception('Erreur de format JSON: $jsonError. Réponse: ${response.body}');
        }
      } else if (response.statusCode == 404) {
        return []; // Pas d'éditeurs trouvés
      } else {
        throw Exception(
            'Erreur lors de la récupération des éditeurs: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('FormatException')) {
        throw Exception('Erreur de format de réponse API. Vérifiez la connexion.');
      }
      throw Exception('Erreur réseau: $e');
    }
  }

  @override
  Future<EditeurModel?> getUserByEmail(String email) async {
    try {
      final token = PreferencesServices.getValue(PreferencesServices.apiTokenKey) as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token API non disponible');
      }

      final rawEmail = email.trim();
      final uri = Uri.parse('${ApiResources.baseUrl}/utilisateurs/email/$rawEmail');
      final response = await httpClient.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      // Debug
      // ignore: avoid_print
      print('GET getUserByEmail → ${uri.toString()} | status=${response.statusCode} | len=${response.bodyBytes.length} | content-type=${response.headers['content-type']}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          // ignore: avoid_print
          print('GET getUserByEmail → 200 avec body vide');
          return null;
        }
        try {
          final dynamic jsonData = json.decode(response.body);
          if (jsonData is Map<String, dynamic>) {
            if (jsonData.containsKey('data') && jsonData['data'] is Map<String, dynamic>) {
              return EditeurModel.fromJson(jsonData['data'] as Map<String, dynamic>);
            }
            return EditeurModel.fromJson(jsonData);
          } else if (jsonData is List) {
            if (jsonData.isEmpty) return null;
            final first = jsonData.first;
            if (first is Map<String, dynamic>) {
              return EditeurModel.fromJson(first);
            }
          }
          return null;
        } catch (jsonError) {
          throw Exception('Erreur de format JSON: $jsonError. Réponse: ${response.body}');
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Erreur lors de la récupération de l\'utilisateur: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('FormatException')) {
        throw Exception('Erreur de format de réponse API. Vérifiez la connexion.');
      }
      throw Exception('Erreur réseau: $e');
    }
  }

  @override
  Future<bool> nommerEditeur(int userId) async {
    try {
      final token = PreferencesServices.getValue(PreferencesServices.apiTokenKey) as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token API non disponible');
      }

      final uri = Uri.parse('${ApiResources.baseUrl}/utilisateurs/$userId/nommer-editeur');
      final response = await httpClient.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      // Debug logs
      // ignore: avoid_print
      print('POST nommerEditeur → ${uri.toString()} | status=${response.statusCode} | body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception('Requête invalide: ${response.body}');
      } else if (response.statusCode == 401) {
        throw Exception('Non autorisé: Token invalide');
      } else if (response.statusCode == 403) {
        throw Exception('Non autorisé: Vous n\'avez pas les permissions requises');
      } else if (response.statusCode == 404) {
        throw Exception('Utilisateur non trouvé');
      } else {
        throw Exception('Erreur serveur: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('FormatException')) {
        throw Exception('Erreur de format de réponse API. Vérifiez la connexion.');
      }
      throw Exception('Erreur lors de la nomination: $e');
    }
  }

  @override
  Future<bool> retirerEditeur(int userId) async {
    try {
      final token = PreferencesServices.getValue(PreferencesServices.apiTokenKey) as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token API non disponible');
      }

      final uri = Uri.parse('${ApiResources.baseUrl}/utilisateurs/$userId/retirer-editeur');
      final response = await httpClient.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      // Debug logs
      // ignore: avoid_print
      print('POST retirerEditeur → ${uri.toString()} | status=${response.statusCode} | body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception('Requête invalide: ${response.body}');
      } else if (response.statusCode == 401) {
        throw Exception('Non autorisé: Token invalide');
      } else if (response.statusCode == 404) {
        throw Exception('Utilisateur non trouvé');
      } else {
        throw Exception('Erreur serveur: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('FormatException')) {
        throw Exception('Erreur de format de réponse API. Vérifiez la connexion.');
      }
      throw Exception('Erreur lors du retrait: $e');
    }
  }
}

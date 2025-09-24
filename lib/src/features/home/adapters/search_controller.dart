// // ========== RECHERCHE ==========

//   Future<void> searchPublications(String motcle) async {
//     // Si motcle vide, remettre liste par défaut
//     if (motcle.trim().isEmpty) {
//       keyword.value = '';
//       setFilteredPublications(publications.value);
//       return;
//     }

//     keyword.value = motcle;
//     isSearching.value = true;
//     isLoadingSearch.value = true;
//     searchError.value = '';

//     try {
//       final uri = Uri.parse('https://mobile.lereservoirdesiloe.com/api/publications/search/${Uri.encodeComponent(motcle)}');
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final body = json.decode(response.body);
//         if (body is List) {
//           final List<EntityPublication> results = body
//               .map((e) => _publicationFromJson(e))
//               .toList();
//           setFilteredPublications(results);
//         } else {
//           // si ton API renvoie { data: [...], ... }
//           if (body['data'] is List) {
//             final List<EntityPublication> results = (body['data'] as List)
//                 .map((e) => _publicationFromJson(e))
//                 .toList();
//             setFilteredPublications(results);
//           } else {
//             // format inattendu
//             searchError.value = 'Format de réponse inattendu';
//           }
//         }
//       } else {
//         searchError.value = 'Erreur serveur ${response.statusCode}';
//       }
//     } catch (e) {
//       searchError.value = 'Erreur : $e';
//     } finally {
//       isLoadingSearch.value = false;
//       update();
//     }
//   }
class ApiRoutes {
  static const String baseUrl = 'https://mobile.lereservoirdesiloe.com/api';

  /// Auth
  static const String loginWithFirebase = '/auth/firebase';
  static const String logout = '/auth/logout';

  /*
    Type de publications
  */

  /// GET all
  static const String typePublications = '/type_publications';

  /// GET, PUT, DELETE by ID
  static String typePublicationById(int id) => '/type_publications/$id';

  /*
    Publications
  */

  /// GET all
  static const String publications = '/publications';

  /// GET, PUT, DELETE by ID
  static String publicationById(int id) => '/publications/$id';

  /*
    Categories
  */

  /// GET all
  static const String categories = '/categories';

  /// GET, PUT, DELETE by ID
  static String categorieById(int id) => '/categories/$id';

  /*
    Commentaires
  */

  // Commentaires
  static String commentairesByPublication(int publicationId) =>
      '/publications/$publicationId/commentaires';
  static String commentaireById(int id) => '/commentaires/$id';
  static String commentaireReplies(int commentaireId) =>
      '/commentaires/$commentaireId/replies';
  static String commentaireReactions(int commentaireId) =>
      '/commentaires/$commentaireId/reactions';
  static String commentaireReport(int commentaireId) =>
      '/commentaires/$commentaireId/report';

  // Admin
  static const String commentairesEnAttente = '/admin/commentaires/en-attente';
  static String approuverCommentaire(int commentaireId) =>
      '/admin/commentaires/$commentaireId/approuver';
  static String rejeterCommentaire(int commentaireId) =>
      '/admin/commentaires/$commentaireId/rejeter';

  /*
    Evenements
  */

  static const String evenements = '/evenements';
  static String evenementById(int id) => '/evenements/$id';

  static String inscrireEvenement(int id) => '/evenements/$id/inscriptions';
  static String listeInscriptions(int id) => '/evenements/$id/inscriptions';
  static String confirmerInscription(int id, int inscriptionId) =>
      '/evenements/$id/inscriptions/$inscriptionId/confirmer';
  static String annulerInscription(int id, int inscriptionId) =>
      '/evenements/$id/inscriptions/$inscriptionId/annuler';

  /*
    Programmes
  */
  static const String programmes = '/programmes';
  static String programmeById(int id) => '/programmes/$id';

  /*
    Demandes de rencontre
  */
  static const String demandesRencontreBase = "/demandes_rencontre";
  static const String demandesRencontreMes =
      "$demandesRencontreBase/mes-demandes";

  static String demandeRencontreShow(int id) => "$demandesRencontreBase/$id";
  static String demandeRencontreUpdate(int id) => "$demandesRencontreBase/$id";
  static String demandeRencontreDelete(int id) => "$demandesRencontreBase/$id";

  static String demandeRencontreAccepter(int id) =>
      "$demandesRencontreBase/$id/accepter";
  static String demandeRencontreRefuser(int id) =>
      "$demandesRencontreBase/$id/refuser";
  static String demandeRencontreAnnuler(int id) =>
      "$demandesRencontreBase/$id/annuler";

  /*
    Requêtes de prière
  */
  static const String requetesPriere = "/requetes_priere";
  static String requetePriereById(int id) => "/requetes_priere/$id";
  static String approuverRequetePriere(int id) =>
      "/requetes_priere/$id/approuver";
  static String rejeterRequetePriere(int id) => "/requetes_priere/$id/rejeter";

  /*
    Dons
  */
  static const String donsHistorique = '/dons/historique';
  static const String dons = '/dons';
  static String donById(int id) => '/dons/$id';
  static const String mesDons = '/dons/mes-dons';
  static const String fedapayCallback = '/paiement/fedapay/callback';

  /*
    Notifications
  */
  static const String notifications = "/notifications";
  static String notificationById(int id) => "/notifications/$id";
  static const String marquerToutesNotifsLues =
      "/notifications/marquer-toutes-lues";

  /*
    Utilisateur
  */
  static const String utilisateurs = '/utilisateurs';
  static String utilisateurById(int id) => "/utilisateurs/$id";
  static const String utilisateurProfile = "/utilisateurs/profile";
  static String utilisateurUpdate(int id) => "/utilisateurs/$id";
  static String utilisateurDelete(int id) => "/utilisateurs/$id";
  static String utilisateurUpdatePhoto(int id) => "/utilisateurs/$id/photo";
  static String utilisateurBan(int id) => "/utilisateurs/$id/ban";
  static String utilisateurUnban(int id) => "/utilisateurs/$id/unban";
}

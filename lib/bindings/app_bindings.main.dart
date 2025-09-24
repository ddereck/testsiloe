part of 'app_bindings.dart';

/// AppBinding class which extends GetX Bindings
///
/// This class specifies the dependencies required by the app,
/// and uses the list of feature bindings generated above.
class AppBinding extends Bindings {
  /// Overrides the dependencies method to register all dependencies
  @override
  void dependencies() {
    /*
      * Firebase
    */

    Get.lazyPut(() => FirebaseResources.firebaseAuth);

    /*
      * Onboarding Controller
    */

    Get.put(OnboardingController());

    /*
      * Post Logging Controller
    */

    Get.put(PostLoggingController());

    /*
      * Launcher Controller
    */

    Get.put(LauncherController());

    /*
      * User Controller
    */
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));
    Get.lazyPut<UserDataSource>(() => UserDataSourceImpl());
    Get.lazyPut<GetUserByIdUseCase>(() => GetUserByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetCurrentUserUseCase>(() => GetCurrentUserUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteCurrentUserAccountUseCase>(
        () => DeleteCurrentUserAccountUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<GetAllUsersUseCase>(() => GetAllUsersUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<BanUserUseCase>(() => BanUserUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UnbanUserUseCase>(() => UnbanUserUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateUserUseCase>(() => UpdateUserUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateUserPhotoUseCase>(() => UpdateUserPhotoUseCase(
          repository: Get.find(),
        ));
    Get.put(UserController(
      getUserByIdUseCase: Get.find<GetUserByIdUseCase>(),
      deleteCurrentUserAccountUseCase:
          Get.find<DeleteCurrentUserAccountUseCase>(),
      getCurrentUserUseCase: Get.find<GetCurrentUserUseCase>(),
      getAllUsersUseCase: Get.find<GetAllUsersUseCase>(),
      banUserUseCase: Get.find<BanUserUseCase>(),
      unbanUserUseCase: Get.find<UnbanUserUseCase>(),
      updateUserUseCase: Get.find<UpdateUserUseCase>(),
      updateUserPhotoUseCase: Get.find<UpdateUserPhotoUseCase>(),
    ));

    /*
      * Authentication Controller
    */
    Get.lazyPut<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(Get.find()));
    Get.lazyPut<AuthenticationDataSource>(
        () => AuthenticationDataSourceImpl(Get.find()));
    Get.lazyPut<SignInWithEmailAndPasswordUseCase>(
        () => SignInWithEmailAndPasswordUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<SignUpWithEmailAndPasswordUseCase>(
        () => SignUpWithEmailAndPasswordUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<LogoutUserUseCase>(() => LogoutUserUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<SignInWithGoogleUseCase>(() => SignInWithGoogleUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<SignInWithAppleUseCase>(() => SignInWithAppleUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<SignInToLaravelUseCase>(() => SignInToLaravelUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<LogoutUserToLaravelUseCase>(() => LogoutUserToLaravelUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<ResetPasswordUseCase>(() => ResetPasswordUseCase(
          repository: Get.find(),
        ));

    Get.put(AuthenticationController(
      signInWithEmailAndPasswordUseCase:
          Get.find<SignInWithEmailAndPasswordUseCase>(),
      signUpWithEmailAndPasswordUseCase:
          Get.find<SignUpWithEmailAndPasswordUseCase>(),
      logoutUserUseCase: Get.find<LogoutUserUseCase>(),
      signInToLaravelUseCase: Get.find<SignInToLaravelUseCase>(),
      logoutUserToLaravelUseCase: Get.find<LogoutUserToLaravelUseCase>(),
      resetPasswordUseCase: Get.find<ResetPasswordUseCase>(),
      signInWithGoogleUseCase: Get.find<SignInWithGoogleUseCase>(),
      signInWithAppleUseCase: Get.find<SignInWithAppleUseCase>(),
    ));

    /*
      * PublicationType Controller
    */
    Get.lazyPut<PublicationTypeRepository>(
        () => PublicationTypeRepositoryImpl(Get.find()));
    Get.lazyPut<PublicationTypeDataSource>(
        () => PublicationTypeDataSourceImpl(Get.find()));
    Get.lazyPut<GetAllPublicationTypeUseCase>(
        () => GetAllPublicationTypeUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<GetPublicationTypeByIdUseCase>(
        () => GetPublicationTypeByIdUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<DeletePublicationTypeUseCase>(
        () => DeletePublicationTypeUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<CreatePublicationTypeUseCase>(
        () => CreatePublicationTypeUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<UpdatePublicationTypeUseCase>(
        () => UpdatePublicationTypeUseCase(
              repository: Get.find(),
            ));

    Get.put(PublicationTypeController(
      getAllPublicationTypeUseCase: Get.find<GetAllPublicationTypeUseCase>(),
      getPublicationTypeByIdUseCase: Get.find<GetPublicationTypeByIdUseCase>(),
      deletePublicationTypeUseCase: Get.find<DeletePublicationTypeUseCase>(),
      createPublicationTypeUseCase: Get.find<CreatePublicationTypeUseCase>(),
      updatePublicationTypeUseCase: Get.find<UpdatePublicationTypeUseCase>(),
    ));

    /*
      * Publication Controller
    */
    Get.lazyPut<PublicationRepository>(
        () => PublicationRepositoryImpl(Get.find()));
    Get.lazyPut<PublicationDataSource>(
        () => PublicationDataSourceImpl(Get.find()));

    Get.lazyPut<GetAllPublicationUseCase>(() => GetAllPublicationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetPublicationByIdUseCase>(() => GetPublicationByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeletePublicationUseCase>(() => DeletePublicationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreatePublicationUseCase>(() => CreatePublicationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdatePublicationUseCase>(() => UpdatePublicationUseCase(
          repository: Get.find(),
        ));

    Get.put(PublicationController(
      getAllPublicationUseCase: Get.find<GetAllPublicationUseCase>(),
      getPublicationByIdUseCase: Get.find<GetPublicationByIdUseCase>(),
      deletePublicationUseCase: Get.find<DeletePublicationUseCase>(),
      createPublicationUseCase: Get.find<CreatePublicationUseCase>(),
      updatePublicationUseCase: Get.find<UpdatePublicationUseCase>(),
    ));

    /*
      * RequetePriere Controller
    */
    Get.lazyPut<RequetePriereRepository>(
        () => RequetePriereRepositoryImpl(Get.find()));
    Get.lazyPut<RequetePriereDataSource>(
        () => RequetePriereDataSourceImpl(Get.find()));

    Get.lazyPut<ApprouverRequetePriereUseCase>(
        () => ApprouverRequetePriereUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<RejeterRequetePriereUseCase>(() => RejeterRequetePriereUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteRequetePriereUseCase>(() => DeleteRequetePriereUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetRequetePriereByIdUseCase>(() => GetRequetePriereByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetRequetesPriereUseCase>(() => GetRequetesPriereUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateRequetePriereUseCase>(() => CreateRequetePriereUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateRequetePriereUseCase>(() => UpdateRequetePriereUseCase(
          repository: Get.find(),
        ));
    Get.put(RequetePriereController(
      approuverRequetePriereUseCase: Get.find<ApprouverRequetePriereUseCase>(),
      rejeterRequetePriereUseCase: Get.find<RejeterRequetePriereUseCase>(),
      deleteRequetePriereUseCase: Get.find<DeleteRequetePriereUseCase>(),
      getRequetePriereByIdUseCase: Get.find<GetRequetePriereByIdUseCase>(),
      getRequetesPriereUseCase: Get.find<GetRequetesPriereUseCase>(),
      createRequetePriereUseCase: Get.find<CreateRequetePriereUseCase>(),
      updateRequetePriereUseCase: Get.find<UpdateRequetePriereUseCase>(),
    ));

    /*
      * Programme Controller
    */
    Get.lazyPut<ProgrammeRepository>(() => ProgrammeRepositoryImpl(Get.find()));
    Get.lazyPut<ProgrammeDataSource>(() => ProgrammeDataSourceImpl(Get.find()));

    Get.lazyPut<GetProgrammesUseCase>(() => GetProgrammesUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetProgrammeByIdUseCase>(() => GetProgrammeByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateProgrammeUseCase>(() => CreateProgrammeUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateProgrammeUseCase>(() => UpdateProgrammeUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteProgrammeUseCase>(() => DeleteProgrammeUseCase(
          repository: Get.find(),
        ));

    Get.put(ProgrammeController(
      getProgrammesUseCase: Get.find<GetProgrammesUseCase>(),
      getProgrammeByIdUseCase: Get.find<GetProgrammeByIdUseCase>(),
      createProgrammeUseCase: Get.find<CreateProgrammeUseCase>(),
      updateProgrammeUseCase: Get.find<UpdateProgrammeUseCase>(),
      deleteProgrammeUseCase: Get.find<DeleteProgrammeUseCase>(),
    ));

    /*
      * Notification Controller
    */

    Get.lazyPut<NotificationRepository>(
        () => NotificationRepositoryImpl(Get.find()));
    Get.lazyPut<NotificationDataSource>(
        () => NotificationDataSourceImpl(Get.find()));
    Get.lazyPut<GetNotificationByIdUseCase>(() => GetNotificationByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteNotificationUseCase>(() => DeleteNotificationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<MarquerNotificationsCommeLuesUseCase>(
        () => MarquerNotificationsCommeLuesUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<CreateNotificationUseCase>(() => CreateNotificationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateNotificationUseCase>(() => UpdateNotificationUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetNotificationsUseCase>(() => GetNotificationsUseCase(
          repository: Get.find(),
        ));

    Get.put(NotificationController(
      getNotificationByIdUseCase: Get.find<GetNotificationByIdUseCase>(),
      deleteNotificationUseCase: Get.find<DeleteNotificationUseCase>(),
      marquerNotificationsCommeLuesUseCase:
          Get.find<MarquerNotificationsCommeLuesUseCase>(),
      createNotificationUseCase: Get.find<CreateNotificationUseCase>(),
      updateNotificationUseCase: Get.find<UpdateNotificationUseCase>(),
      getNotificationsUseCase: Get.find<GetNotificationsUseCase>(),
    ));

    /*
      * EvenementInscription Controller
    */
    Get.lazyPut<EvenementInscriptionRepository>(
        () => EvenementInscriptionRepositoryImpl(Get.find()));
    Get.lazyPut<EvenementInscriptionDataSource>(
        () => EvenementInscriptionDataSourceImpl(Get.find()));

    Get.lazyPut<AnnulerInscriptionUseCase>(() => AnnulerInscriptionUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<ConfirmerInscriptionUseCase>(() => ConfirmerInscriptionUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetInscriptionsUseCase>(() => GetInscriptionsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<InscrireEvenementUseCase>(() => InscrireEvenementUseCase(
          repository: Get.find(),
        ));

    Get.put(EvenementInscriptionController(
      annulerInscriptionUseCase: Get.find<AnnulerInscriptionUseCase>(),
      confirmerInscriptionUseCase: Get.find<ConfirmerInscriptionUseCase>(),
      getInscriptionsUseCase: Get.find<GetInscriptionsUseCase>(),
      inscrireEvenementUseCase: Get.find<InscrireEvenementUseCase>(),
    ));

    /*
      * Evenement Controller
    */
    Get.lazyPut<EvenementRepository>(() => EvenementRepositoryImpl(Get.find()));
    Get.lazyPut<EvenementDataSource>(() => EvenementDataSourceImpl(Get.find()));

    Get.lazyPut<GetAllEvenementsUseCase>(() => GetAllEvenementsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetEvenementByIdUseCase>(() => GetEvenementByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateEvenementUseCase>(() => CreateEvenementUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateEvenementUseCase>(() => UpdateEvenementUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteEvenementUseCase>(() => DeleteEvenementUseCase(
          repository: Get.find(),
        ));

    Get.put(EvenementController(
      getAllEvenementsUseCase: Get.find<GetAllEvenementsUseCase>(),
      getEvenementByIdUseCase: Get.find<GetEvenementByIdUseCase>(),
      createEvenementUseCase: Get.find<CreateEvenementUseCase>(),
      updateEvenementUseCase: Get.find<UpdateEvenementUseCase>(),
      deleteEvenementUseCase: Get.find<DeleteEvenementUseCase>(),
    ));

    /*
      * Don Controller
    */
    Get.lazyPut<DonRepository>(() => DonRepositoryImpl(Get.find()));
    Get.lazyPut<DonDataSource>(() => DonDataSourceImpl(Get.find()));
    Get.lazyPut<GetDonByIdUseCase>(() => GetDonByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetDonsHistoriquePublicUseCase>(
        () => GetDonsHistoriquePublicUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<GetMesDonsUseCase>(() => GetMesDonsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetDonsAdminUseCase>(() => GetDonsAdminUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteDonUseCase>(() => DeleteDonUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateDonUseCase>(() => CreateDonUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<FedapayCallbackUseCase>(() => FedapayCallbackUseCase(
          repository: Get.find(),
        ));
    Get.put(DonController(
      getDonByIdUseCase: Get.find<GetDonByIdUseCase>(),
      getDonsHistoriquePublicUseCase:
          Get.find<GetDonsHistoriquePublicUseCase>(),
      getMesDonsUseCase: Get.find<GetMesDonsUseCase>(),
      getDonsAdminUseCase: Get.find<GetDonsAdminUseCase>(),
      deleteDonUseCase: Get.find<DeleteDonUseCase>(),
      createDonUseCase: Get.find<CreateDonUseCase>(),
      fedapayCallbackUseCase: Get.find<FedapayCallbackUseCase>(),
    ));

    /*
      * DemandeRencontre Controller
    */
    Get.lazyPut<DemandeRencontreRepository>(
        () => DemandeRencontreRepositoryImpl(Get.find()));
    Get.lazyPut<DemandeRencontreDataSource>(
        () => DemandeRencontreDataSourceImpl(Get.find()));

    Get.lazyPut<GetDemandesRencontreUseCase>(() => GetDemandesRencontreUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetMesDemandesRencontreUseCase>(
        () => GetMesDemandesRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<GetDemandeRencontreByIdUseCase>(
        () => GetDemandeRencontreByIdUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<AccepterDemandeRencontreUseCase>(
        () => AccepterDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<RefuserDemandeRencontreUseCase>(
        () => RefuserDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<AnnulerDemandeRencontreUseCase>(
        () => AnnulerDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<CreateDemandeRencontreUseCase>(
        () => CreateDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<UpdateDemandeRencontreUseCase>(
        () => UpdateDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<DeleteDemandeRencontreUseCase>(
        () => DeleteDemandeRencontreUseCase(
              repository: Get.find(),
            ));
    Get.put(DemandeRencontreController(
      getDemandesRencontreUseCase: Get.find<GetDemandesRencontreUseCase>(),
      getMesDemandesRencontreUseCase:
          Get.find<GetMesDemandesRencontreUseCase>(),
      getDemandeRencontreByIdUseCase:
          Get.find<GetDemandeRencontreByIdUseCase>(),
      accepterDemandeRencontreUseCase:
          Get.find<AccepterDemandeRencontreUseCase>(),
      refuserDemandeRencontreUseCase:
          Get.find<RefuserDemandeRencontreUseCase>(),
      annulerDemandeRencontreUseCase:
          Get.find<AnnulerDemandeRencontreUseCase>(),
      createDemandeRencontreUseCase: Get.find<CreateDemandeRencontreUseCase>(),
      updateDemandeRencontreUseCase: Get.find<UpdateDemandeRencontreUseCase>(),
      deleteDemandeRencontreUseCase: Get.find<DeleteDemandeRencontreUseCase>(),
    ));

    /*
      * CommentaireReport Controller
    */
    Get.lazyPut<CommentaireReportRepository>(
        () => CommentaireReportRepositoryImpl(Get.find()));
    Get.lazyPut<CommentaireReportDataSource>(
        () => CommentaireReportDataSourceImpl(Get.find()));
    Get.put(CommentaireReportController());

    /*
      * CommentaireEeaction Controller
    */
    Get.lazyPut<CommentaireReactionRepository>(
        () => CommentaireReactionRepositoryImpl(Get.find()));
    Get.lazyPut<CommentaireReactionDataSource>(
        () => CommentaireReactionDataSourceImpl(Get.find()));
    Get.put(CommentaireReactionController());

    /*
      * Commentaire Controller
    */
    Get.lazyPut<CommentaireRepository>(
        () => CommentaireRepositoryImpl(Get.find()));
    Get.lazyPut<CommentaireDataSource>(
        () => CommentaireDataSourceImpl(Get.find()));

    Get.lazyPut<CreateCommentaireUseCase>(() => CreateCommentaireUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetCommentairesUseCase>(() => GetCommentairesUseCase(
          repository: Get.find(),
        ));

    Get.put(CommentaireController(
      createCommentaireUseCase: Get.find<CreateCommentaireUseCase>(),
      getCommentairesUseCase: Get.find<GetCommentairesUseCase>(),
    ));

    /*
      * Categorie Controller
    */
    Get.lazyPut<CategorieRepository>(() => CategorieRepositoryImpl(Get.find()));
    Get.lazyPut<CategorieDataSource>(() => CategorieDataSourceImpl(Get.find()));

    Get.lazyPut<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GetCategorieByIdUseCase>(() => GetCategorieByIdUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteCategorieUseCase>(() => DeleteCategorieUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateCategorieUseCase>(() => CreateCategorieUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<UpdateCategorieUseCase>(() => UpdateCategorieUseCase(
          repository: Get.find(),
        ));

    Get.put(CategorieController(
      getAllCategoriesUseCase: Get.find<GetAllCategoriesUseCase>(),
      getCategorieByIdUseCase: Get.find<GetCategorieByIdUseCase>(),
      deleteCategorieUseCase: Get.find<DeleteCategorieUseCase>(),
      createCategorieUseCase: Get.find<CreateCategorieUseCase>(),
      updateCategorieUseCase: Get.find<UpdateCategorieUseCase>(),
    ));
  }
}

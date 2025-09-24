part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  try {
    // Firebase initialisation
    await firebaseInitDependencies();

    // FirebaseMessaging initialisation
    
    await GetStorage.init('Theme');
    await GetStorage.init('AppPreferences');
    //await ThemeManager.initialise();
    await AppInfosService.init();

    // AwesomeNotification initialisation
    await awesomeNotificationDependencies();
  } catch (e) {
    debugPrint(e.toString());
  }
}


Future<void> firebaseInitDependencies() async {
  // Firebase initialisation
  // Code (--no-localhost) C9BAC | 4/0AVMBsJiivVsCsOptUvZl93aXfeLDBI_YeZbPRnxmhfqriR49U3tx0iz_RXIiaO1Jcemupg
  await FirebaseResources.init(
    // demoProjectId: kD,
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> awesomeNotificationDependencies() async {

}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseApp, Firebase, FirebaseOptions;

class FirebaseResources {

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => firebaseAuth.currentUser;

  static Stream<User?> userChanges() => firebaseAuth.userChanges();

  static Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  static FirebaseApp? get app => Firebase.app();
  static FirebaseApp instance = Firebase.app();


  static Future<void> init({
    String? name,
    FirebaseOptions? options,
    String? demoProjectId,
  }) async {
    instance = await Firebase.initializeApp(
      name: name,
      options: options,
      demoProjectId: demoProjectId,
    );
  }

}
import '../logs/custom_logger.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'env_datas.dart';

/// The EnvObject class is responsible for loading and providing the environment
/// variables to the app.
///
/// The generated EnvObject class is based on the features strategy and the
/// environment variables.
///
/// The EnvObject class contains properties for each environment variable.
/// The properties are named in camel case.
///
/// The EnvObject class also contains a method to check if all the required
/// environment variables are defined.
///
/// The EnvObject class is a singleton.
class EnvObject {
  EnvObject._internal();
  static final EnvObject _instance = EnvObject._internal();
  factory EnvObject() => _instance;

  /// Whether the EnvObject has been loaded
  static bool _isLoaded = false;

  /// The environment variables
  ///
  /// The properties are named in camel case.
  ///
  /// The properties are loaded from the environment variables using the
  /// [dotenv] package.
  /// The environment variable SupabaseUrl
static late String supabaseUrl;
	/// The environment variable SupabaseKey
static late String supabaseKey;
	/// The environment variable AppStatus
static late String appStatus;
	/// The environment variable AppEnvironnement
static late String appEnvironnement;

  /// Checks if all the required environment variables are defined
  ///
  /// Returns true if all the required environment variables are defined.
  /// Returns false otherwise.
  static bool checkRequiredVariables(List<String> variables) {
    return dotenv.isEveryDefined(variables);
  }

  /// Loads the environment variables
  ///
  /// The environment variables are loaded from the environment variables using
  /// the [dotenv] package.
  ///
  /// The method is asynchronous and returns a Future.
  ///
  /// The method is idempotent.
  static Future<void> load({required Map<String, String> envVars}) async {

    AppLogger.instance.logger.i("🔹 INIT ENV OBJECT");
    if (_isLoaded) return;
    _isLoaded = true;

    // Get values
    supabaseUrl = envVars[EnvDatas.supabaseUrl] ?? '';
		supabaseKey = envVars[EnvDatas.supabaseKey] ?? '';
		appStatus = envVars[EnvDatas.appStatus] ?? '';
		appEnvironnement = envVars[EnvDatas.appEnvironnement] ?? '';

    AppLogger.instance.logger.i("🔹 ENV Loaded (VARS) => $envVars");
    _isLoaded = false;
  }
}


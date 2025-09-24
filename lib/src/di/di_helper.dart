
import 'package:get/get.dart';

class DiHelper {
  /// Get a controller if it exists, otherwise create it (lazy or not)
  static T findOrCreate<T extends GetxController>(
      {T Function()? creator, bool lazy = false}) {
    if (Get.isRegistered<T>()) {
      return Get.find<T>(); // Return the existing instance
    } else {
      if (creator != null) {
        // Cases where a custom constructor is provided
        if (lazy) {
          Get.lazyPut<T>(creator);
        } else {
          return Get.put<T>(creator());
        }
      } else {
        // Cases where no constructor is provided (requires an empty constructor)
        if (lazy) {
          Get.lazyPut<T>(() => Get.put<T>(_createInstance<T>()));
        } else {
          return Get.put<T>(_createInstance<T>());
        }
      }
      return Get.find<T>(); // Returns the newly created instance
    }
  }

  /// Attempts to create an instance of a generic controller without parameters
  static T _createInstance<T extends GetxController>() {
    try {
      return Get.put<T>(T.toString() as T);
    } catch (e) {
      throw Exception(
          "Cannot create an instance of $T. Make sure it has a parameterless constructor or use findOrCreate with a creator.");
    }
  }
}

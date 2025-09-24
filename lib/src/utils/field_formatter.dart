import 'package:get/get_utils/get_utils.dart';

class FieldFormatter {
  
  // Vérifie si l'email est valide
  static bool isValidEmail(String email) {
    // Utilisation d'une expression régulière pour valider le format de l'email
    //String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    //RegExp regex = RegExp(pattern);
    return GetUtils.isEmail(email);
  }

  // Vérifie si le mot de passe est valide
  static bool isValidPassword(String password) {
    // Le mot de passe doit avoir au moins 8 caractères, 
    // une lettre majuscule, une lettre minuscule et un chiffre
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
    RegExp regex = RegExp(pattern);
    bool isMatching = regex.hasMatch(password);
    if(!isMatching) return false;
    return GetUtils.isLengthGreaterOrEqual(password, 8);
  }

  static bool isValidatePassword(String password) {
    // Vérifie que le mot de passe a au moins 8 caractères
    if (password.length < 8) return false;

    // Vérifie qu'il contient au moins une lettre majuscule
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));

    // Vérifie qu'il contient au moins une lettre minuscule
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    // Vérifie qu'il contient au moins un chiffre
    bool hasDigit = password.contains(RegExp(r'[0-9]'));

    // Vérifie qu'il contient au moins un caractère spécial
    bool hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Retourne true si toutes les conditions sont remplies
    return hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter;
  }

  // Vérifie si le numéro de téléphone est valide
  static bool isValidPhoneNumber(String phoneNumber) {
    // Exemple d'un format de numéro de téléphone valide (10 chiffres)
    // String pattern = r'^\d{10}$';
    // RegExp regex = RegExp(pattern);
    return GetUtils.isPhoneNumber(phoneNumber);
  }

  static bool isValidNumeric(String value) {
    return GetUtils.isNum(value);
  }

  static bool isNotEmpty(String value) {
    return value.isNotEmpty;
  }

  static bool isValidName(String name) {
    return name.isNotEmpty && name.length > 1;
  }

  static String? validatorEmail(dynamic value) {
    if(!isValidEmail(value.toString().trim())) return "Invalid email format";
    return null;
  }

  static String? validatorEmpty(dynamic value, {bool additionnalCheck = true}) {
    if(!isNotEmpty(value) && additionnalCheck) return "Field can't be empty";
    return null;
  }

  static String? validatorPhone(dynamic value, {additionnalCheck = true}) {
    if(!isValidPhoneNumber(value) && additionnalCheck) return "Invalid phone number format";
    return null;
  }

  static String? validatorNumeric(dynamic value) {
    if(!isValidNumeric(value)) return "Invalid numeric format";
    return null;
  }

  static String? validatorOtp(dynamic value) {
    if(!isValidNumeric(value)) return "Invalid numeric format";
    return null;
  }

  static String? validatorUrl(dynamic value, {additionnalCheck = true}) {
    if(!GetUtils.isURL(value) && additionnalCheck) return "Invalid url format";
    return null;
  }

  static String? validatorPassword(String password) {
    if (password.isEmpty) {
      return "Le mot de passe est requis.";
    }
    if (password.length < 8) {
      return "Le mot de passe doit contenir au moins 8 caractères.";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Le mot de passe doit contenir au moins une lettre majuscule.";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Le mot de passe doit contenir au moins une lettre minuscule.";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Le mot de passe doit contenir au moins un chiffre.";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Le mot de passe doit contenir au moins un caractère spécial.";
    }

    return null; // ✅ Valide
  }

  static String? validateConfirmedPassword(String password, String confirmedPassword) {
    if (confirmedPassword.isEmpty) {
      return "La confirmation du mot de passe est requise.";
    }
    if (password != confirmedPassword) {
      return "Les mots de passe ne correspondent pas.";
    }
    return null; // ✅ Valide
  }
}
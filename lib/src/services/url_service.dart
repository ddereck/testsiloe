import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../commons/functions/widgets_functions.dart';

class UrlService {

  static Future<bool> launchUrlInBrowser(String url) async {

    try {
      final result = await canLaunchUrlString(url);
      if(result) {
        return await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

  }

  static Future<void> launchInBrowser(BuildContext context, {required String url}) async {
    if (!await launchUrlInBrowser(url)) {
      customSnackBar(title: "Une error est survenue", message: "Le lien n'a pas pu s'ouvrir", isError: true);
    }
  }

  static Future<void> launchWhatsApp(String whatsApp) async {
    try {
      await launchUrl(Uri.parse("https://wa.me/$whatsApp"));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> launchWebsite(String website) async {
    try {
      await launchUrl(Uri.parse(website));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> launchEmail(String email) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      await launchUrl(emailLaunchUri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}


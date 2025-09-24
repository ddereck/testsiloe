import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class AppAllUtils{

  static Future<void> makePhoneCall(String phoneNumebr) async {
    String finalURL = 'tel://$phoneNumebr';
    if (await canLaunchUrl(Uri.parse(finalURL))) {
      await launchUrl(Uri.parse(finalURL));
    } else {
      throw 'Could not launch $finalURL';
    }
  }
  static openWhatsapp(String phoneNumber) async {
    var whatsapp = phoneNumber;
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
    var whatAppURLIos = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatAppURLIos))) {
        await launchUrl(Uri.parse(whatAppURLIos));
      } else {
        throw 'Could not launch $whatAppURLIos';
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        throw 'Could not launch $whatsappURlAndroid';
      }
    }
  }
}
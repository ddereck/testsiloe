import 'package:flutter/material.dart';

class TextConfig {
  static TextStyle getSimpleTextStyle(
    bool bold, {
    Color? color,
    int? size,
    bool withFont = true,
    String? font,
    bool underline = false,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    FontStyle? fontStyle,
    Paint? foreground,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: null,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      fontWeight: fontWeight ?? (bold ? FontWeight.bold : FontWeight.normal),
      fontSize: size?.toDouble(),
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontStyle: fontStyle,
      foreground: foreground,
    );
  }

  static RegExp regExpForRemoveHTMLTags = RegExp(r"<[^>]*>");
  static RegExp nbsp = RegExp(r"&nbsp;");

  static String textWorker(String str) {
    String option1 = str.replaceAll(TextConfig.regExpForRemoveHTMLTags, "");
    String option2 = option1.replaceAll(TextConfig.nbsp, " ");
    return option2;
  }

  static String formatDate(String? date) {
    if (date == null || date.isEmpty) return '-';
    final dt = DateTime.tryParse(date);
    if (dt == null) return '-';
    final mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${dt.day} ${mois[dt.month - 1]} ${dt.year}';
  }
}

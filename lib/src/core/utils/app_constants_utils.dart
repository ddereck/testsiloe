import 'package:flutter/material.dart';

/// A utility class for defining application-wide constants.
///
/// This class is meant to hold constant values that are used
/// throughout the application.
class AppConstantsUtils {

  /// Column Spacing
  static const double columnSpacingSmall = 4.0;
  static const double columnSpacingMedium = 8.0;
  static const double columnSpacingLarge = 12.0;

  /// Row Spacing
  static const double rowSpacingSmall = 4.0;
  static const double rowSpacingMedium = 8.0;
  static const double rowSpacingLarge = 12.0;

  static const double scaffoldHPadding = 20.0;
  static const double scaffoldVPadding = 20.0;

  static const double buttonHPadding = 20.0;
  static const double buttonVPadding = 5.0;

  static const double containerHPadding = 10.0;
  static const double containerVPadding = 10.0;

  
  static const double widgetPaddingSmallIcon = 2.5;
  static const double widgetPaddingSmall = 5.0;
  static const double widgetPaddingMedium = 10.0;
  static const double widgetPaddingLarge = 15.0;

  static const double itemSpacing = 10.0;
  static const double itemSpacingDualSide = 5.0;
  static const double itemSpacingSmall = 2.5;

  static const double widgetSpacingBase = 20.0;
  static const double widgetSpacingSmall = 10.0;
  

  static const int hightTitleSize = 30;
  static const int titleSize = 20;
  static const int subTitleSize = 16;
  static const int contentSize = 15;
  static const int smallSize = 12;
  static const int tinySize = 10;

  static const double radius = 10.0;
  static const double radiusMedium = 15.0;
  static const double radiusLarge = 20.0;
  static const double radiusSmall = 5.0;

  static const double iconSize = 20.0;
  static const double iconSizeSmall = 10.0;
  static const double iconSizeMiddle = 25.0;
  static const double iconSizeMiddleSelected = 25.0;
  static const double iconSizeMedium = 30.0;
  static const double iconSizeLarge = 50.0;
  static const double iconSizeLargeSelected = 35.0;

  static const int polylineWidth = 5;

  static double scaffoldWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double scaffoldHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

  // La barre d'état (status bar)
  static double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top; 
  // La barre de navigation (navigation bar)
  static double navigationBarHeight(BuildContext context) => MediaQuery.of(context).padding.bottom;
}

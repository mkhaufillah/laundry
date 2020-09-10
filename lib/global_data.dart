import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Define global class for global static data store
class GlobalData {
  // Define color schema for app theme
  static const Color PRIMARY_COLOR = Color(0XFF536DFE);
  static const Color ACCENT_COLOR = Color(0XFFF9A826);
  static const Color BACKGROUND_COLOR = Color(0XFFFDFDFD);
  static const Color FOREGROUND_COLOR = Color(0XFF212121);
  static const Color ERROR_COLOR = Color(0XFFE84545);
  static const Color SUCCESS_COLOR = Color(0XFF1FAB89);
  static const Color GREY_COLOR = Color(0XFFE0E0E0);
  static const Color GREY_DARK_COLOR = Color(0XFF757575);
  static const Color GREY_LIGHT_COLOR = Color(0XFFEEEEEE);

  // Define constistent padding and margin
  static const double BODY_MARGIN_PADDING = 16.0;
  static const double COMPONENT_MARGIN_PADDING = 13.0;

  // Define token access for resources
  static const String JWT =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.VSQqLoqlIfKU9FjbAL0zgtD3oxvafbPrhvzFo865Dp0';
}

/// Extension for number datatype
extension NumberExtension on num {
  /// For parse number to IDR currency
  String parseToIdrCurrency() {
    var f = NumberFormat.decimalPattern("id_ID");
    return 'Rp ' + f.format(this).toString();
  }

  /// For parse separated point number
  String parseToSeparatedPointNumber() {
    var f = NumberFormat.decimalPattern("id_ID");
    return f.format(this).toString();
  }
}

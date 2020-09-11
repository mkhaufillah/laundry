import 'package:flutter/material.dart';
import 'package:laundry/global_data.dart';

/// Type of button
enum CustomButtonType {
  DEFAULT,
  PRIMARY,
  ACCENT,
}

/// Main class of custom button
class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final String text;

  final Function onPressed;

  CustomButton({
    @required this.type,
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: type == CustomButtonType.DEFAULT
          ? GlobalData.GREY_LIGHT_COLOR
          : type == CustomButtonType.PRIMARY
              ? GlobalData.PRIMARY_COLOR
              : GlobalData.ACCENT_COLOR,
      colorBrightness: type == CustomButtonType.DEFAULT
          ? Brightness.light
          : type == CustomButtonType.PRIMARY
              ? Brightness.dark
              : Brightness.light,
      child: Text(text.toUpperCase()),
      onPressed: onPressed,
    );
  }
}

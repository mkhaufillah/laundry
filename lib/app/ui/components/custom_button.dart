import 'package:flutter/material.dart';
import 'package:laundry/global_data.dart';

/// Type of button
enum CustomButtonType {
  DEFAULT,
  PRIMARY,
  ACCENT,
  DISABLE,
  LOADING,
}
enum CustomButtonSize {
  DEFAULT,
  SMALL,
  BIG,
}

/// Main class of custom button
class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final CustomButtonSize size;
  final String text;
  final bool isFullWidth;

  final Function onPressed;

  CustomButton({
    this.type,
    this.size,
    @required this.text,
    @required this.onPressed,
    this.isFullWidth,
  });

  @override
  Widget build(BuildContext context) {
    RaisedButton button = RaisedButton(
      color: type == null ||
              type == CustomButtonType.DEFAULT ||
              type == CustomButtonType.LOADING
          ? GlobalData.GREY_LIGHT_COLOR
          : type == CustomButtonType.PRIMARY
              ? GlobalData.PRIMARY_COLOR
              : type == CustomButtonType.ACCENT
                  ? GlobalData.ACCENT_COLOR
                  : GlobalData.GREY_DARK_COLOR,
      colorBrightness:
          type == CustomButtonType.PRIMARY || type == CustomButtonType.DISABLE
              ? Brightness.dark
              : Brightness.light,
      child: type == CustomButtonType.LOADING
          ? CircularProgressIndicator()
          : Text(
              text.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
      onPressed: onPressed,
      padding: size == null || size == CustomButtonSize.DEFAULT
          ? EdgeInsets.only(
              bottom: GlobalData.COMPONENT_MARGIN_PADDING,
              top: GlobalData.COMPONENT_MARGIN_PADDING,
              left: GlobalData.COMPONENT_MARGIN_PADDING * 2,
              right: GlobalData.COMPONENT_MARGIN_PADDING * 2,
            )
          : size == CustomButtonSize.BIG
              ? EdgeInsets.only(
                  bottom: GlobalData.COMPONENT_MARGIN_PADDING * 1.5,
                  top: GlobalData.COMPONENT_MARGIN_PADDING * 1.5,
                  left: GlobalData.COMPONENT_MARGIN_PADDING * 2.5,
                  right: GlobalData.COMPONENT_MARGIN_PADDING * 2.5,
                )
              : EdgeInsets.only(
                  bottom: GlobalData.COMPONENT_MARGIN_PADDING * 0.7,
                  top: GlobalData.COMPONENT_MARGIN_PADDING * 0.7,
                  left: GlobalData.COMPONENT_MARGIN_PADDING,
                  right: GlobalData.COMPONENT_MARGIN_PADDING,
                ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          GlobalData.BORDER_RADIUS,
        ),
      ),
    );
    if (isFullWidth != null && isFullWidth)
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    else
      return button;
  }
}

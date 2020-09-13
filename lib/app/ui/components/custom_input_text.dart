import 'package:flutter/material.dart';
import 'package:laundry/global_data.dart';

class CustomInputText extends StatelessWidget {
  final String label;
  final String err;
  final String hint;
  final Function(String) onChanged;
  final TextInputType type;
  final FocusNode focusNode;

  CustomInputText({
    this.type,
    this.label,
    this.err,
    this.hint,
    this.focusNode,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type == null ? TextInputType.text : type,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: GlobalData.GREY_LIGHT_COLOR,
        contentPadding: const EdgeInsets.only(
          left: GlobalData.COMPONENT_MARGIN_PADDING,
          right: GlobalData.COMPONENT_MARGIN_PADDING,
          bottom: GlobalData.COMPONENT_MARGIN_PADDING / 2,
          top: GlobalData.COMPONENT_MARGIN_PADDING / 2,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(GlobalData.BORDER_RADIUS),
          borderSide: BorderSide(color: GlobalData.GREY_LIGHT_COLOR),
        ),
        labelText: label == null ? '' : label,
        errorText: err,
        hintText: hint == null ? '' : hint,
      ),
      onChanged: onChanged,
    );
  }
}

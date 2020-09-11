import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry/global_data.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  CustomAppBar({@required this.title}) : super(key: Key('primary-app-bar'));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [GlobalData.SHADOW]),
      child: AppBar(
        brightness: Brightness.light,
        actionsIconTheme: IconThemeData(color: GlobalData.FOREGROUND_COLOR),
        iconTheme: IconThemeData(color: GlobalData.FOREGROUND_COLOR),
        title: Text(
          this.title,
          style: TextStyle(
            color: GlobalData.FOREGROUND_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}

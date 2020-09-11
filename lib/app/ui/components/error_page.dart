import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry/global_data.dart';

class ErrorPage extends StatelessWidget {
  final String text;

  ErrorPage({this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height - GlobalData.BODY_MARGIN_PADDING * 2,
      padding: EdgeInsets.all(
        GlobalData.BODY_MARGIN_PADDING,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/error.svg',
            semanticsLabel: 'Error Load Data',
            alignment: Alignment.center,
            width: (width - GlobalData.BODY_MARGIN_PADDING * 2) * 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(
              GlobalData.COMPONENT_MARGIN_PADDING * 2,
            ),
          ),
          Text(
            text == null
                ? 'Kesalahan memuat data,\nsilahkan restart aplikasi'
                : text,
          ),
        ],
      ),
    );
  }
}

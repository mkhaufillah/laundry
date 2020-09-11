import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry/global_data.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(
        GlobalData.BODY_MARGIN_PADDING,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/processing.svg',
            semanticsLabel: 'Loading Data',
            alignment: Alignment.center,
            width: (width - GlobalData.BODY_MARGIN_PADDING * 2) * 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(
              GlobalData.COMPONENT_MARGIN_PADDING * 2,
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

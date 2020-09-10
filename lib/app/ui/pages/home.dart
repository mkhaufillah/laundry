import 'package:flutter/material.dart';
import 'package:laundry/global_data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(
            GlobalData.COMPONENT_MARGIN_PADDING,
          ),
          child: Text("That's works"),
        ),
      ),
    );
  }
}

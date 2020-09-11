import 'package:flutter/material.dart';
import 'package:laundry/global_data.dart';

class CardHomeMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function onTap;

  CardHomeMenu({
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: GlobalData.COMPONENT_MARGIN_PADDING),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(
                GlobalData.COMPONENT_MARGIN_PADDING,
              ),
              leading: Icon(
                icon,
                color: GlobalData.PRIMARY_COLOR,
              ),
              title: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: GlobalData.FOREGROUND_COLOR),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: GlobalData.FOREGROUND_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

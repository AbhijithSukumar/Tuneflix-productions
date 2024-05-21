import 'package:flutter/material.dart';

class TuneFlixDashboardCard extends StatelessWidget {
  const TuneFlixDashboardCard(
      {super.key,
      required this.dashIcon,
      required this.dashIconColor,
      required this.dashIconTitle,
      required this.tapFunc
      });
  final IconData dashIcon;
  final Color dashIconColor;
  final String dashIconTitle;
  final dynamic tapFunc;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        enableFeedback: false,
        excludeFromSemantics: false,
        splashColor: Colors.green,
        onTap: tapFunc,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.2)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    dashIcon,
                    color: dashIconColor,
                    size: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text(dashIconTitle)
                ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TuneFlixDashboardDrawerIcon extends StatelessWidget {
  const TuneFlixDashboardDrawerIcon({super.key,required this.drawerIcon,required this.drawerIconText});
  final IconData drawerIcon;
  final String drawerIconText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){},
        enableFeedback: false,
        excludeFromSemantics: false,
        splashColor: Colors.green,
        child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.09,
                    child: ListTile(
                      leading: Icon(
                        drawerIcon,
                        size: MediaQuery.of(context).size.height*0.05,
                        color: Colors.green,
                        ),
                      title:  Text(drawerIconText),
                    ),
                  ),
      ),
    );
  }
}
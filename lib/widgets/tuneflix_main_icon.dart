import 'package:flutter/material.dart';


class TuneFlixMainIcon extends StatelessWidget {
  const TuneFlixMainIcon({super.key, required this.spacing, required this.iconColor, required this.textColor});
  final double spacing;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: spacing,
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   Icon(Icons.play_circle_filled,size: MediaQuery.of(context).size.width*0.4,color: iconColor,),
                   Text("TUNEFLIX",
                  style: TextStyle(
                    color: textColor,
                    fontSize: MediaQuery.of(context).size.width*0.04
                  ),
                  )
                ],
              ),
            );
  }
}
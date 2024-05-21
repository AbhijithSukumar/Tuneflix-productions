import 'package:flutter/material.dart';

class TuneFlixFormTitle extends StatelessWidget {
  const TuneFlixFormTitle({super.key,required this.formTitle,required this.titleTopPadding});
  final String formTitle;
  final double titleTopPadding;

  @override
  Widget build(BuildContext context) {
    return  Padding(
                 padding:  EdgeInsets.only(
                  top: titleTopPadding,
                  left: MediaQuery.of(context).size.height*0.04
                  ),
                 child: Text(formTitle,
                 textAlign: TextAlign.left,
                 style: TextStyle(
                  color: Colors.green,
                  fontSize: MediaQuery.of(context).size.width*0.06,
                  fontWeight: FontWeight.w600,
                 ),
                 ),
               );
  }
}
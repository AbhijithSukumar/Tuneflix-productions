import 'package:flutter/material.dart';

class TuneFlixFormLabel extends StatelessWidget {
  const TuneFlixFormLabel({super.key,required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
                 padding:  EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.04,
                  left: MediaQuery.of(context).size.height*0.04
                  ),
                 child:  Text(label,
                 style: const TextStyle(
                  color: Colors.green
                 ),
                 ),
               );
  }
}
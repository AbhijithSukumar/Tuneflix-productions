import 'package:flutter/material.dart';

class TuneFlixFormButton extends StatelessWidget {
  const TuneFlixFormButton({super.key,required this.onFormSubmit});
  final dynamic onFormSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                height: MediaQuery.of(context).size.height*0.09,
                 child: Center(
                   child: MaterialButton(
                    splashColor: Colors.green,
                    highlightColor: Colors.green,
                    elevation: 15,
                    minWidth: MediaQuery.of(context).size.width*0.3,
                   color: Colors.white,
                   textColor: Colors.black,
                   onPressed: onFormSubmit,
                   child: const Text(
                    "submit",
                    )
                   ),
                 ),
               );
  }
}
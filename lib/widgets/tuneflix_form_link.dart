import 'package:flutter/material.dart';

class TuneFlixFormLink extends StatelessWidget {
  const TuneFlixFormLink({super.key,required this.linkText,required this.linkFunc});
  final String linkText;
  final dynamic linkFunc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                    child: TextButton(onPressed: linkFunc, 
                    child:Center(
                      child: Text(linkText,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                      ),
                    )
                    ),
                  );
  }
}
import 'package:flutter/material.dart';

class TuneFlixFormField extends StatefulWidget {
 const TuneFlixFormField({super.key,required this.formController,required this.hint,required this.validatorFunc,required this.obscureText,required this.maximumLines});
  final dynamic formController;
  final String hint; 
  final dynamic validatorFunc;
  final bool obscureText;
  final int maximumLines;

  @override
  State<TuneFlixFormField> createState() => _TuneFlixFormFieldState();
}

class _TuneFlixFormFieldState extends State<TuneFlixFormField> {
  bool obText=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
                 padding:  EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height*0.01,
                  horizontal: MediaQuery.of(context).size.height*0.04
                  ),
                 child: TextFormField(
                  maxLines: widget.maximumLines,
                  obscureText: widget.obscureText?obText:false,
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: widget.formController,
                  validator: widget.validatorFunc,
                  decoration:  InputDecoration(
                    suffixIcon: widget.obscureText?
                     InkWell(
                      onTap: (){
                        setState(() {
                          obText=!obText;
                        });
                      },
                      child:  Icon(
                        obText?Icons.visibility_off
                        :Icons.visibility,
                        color: Colors.green,
                      ),
                    )
                    :null,
                    hintText: widget.hint,
                    hintStyle: const TextStyle(
                      color: Colors.green,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width*0.005
                      )
                    ),
                    errorBorder: 
                    OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width*0.005
                      )
                    ),
                    focusedBorder: 
                    OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width*0.008
                      )
                    ),
                  ),
                 ),
               );
  }
}
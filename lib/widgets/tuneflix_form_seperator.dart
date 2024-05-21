import 'package:flutter/material.dart';

class TuneFlixFormSeperator extends StatelessWidget {
  const TuneFlixFormSeperator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Divider(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: const Text(
                              "OR",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Divider(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}
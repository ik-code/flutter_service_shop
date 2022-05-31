import 'package:flutter/material.dart';
import 'package:playground/utilities/constans.dart';

class RaisedButtonPG extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedHandler;

  const RaisedButtonPG(
      {required this.text, required this.onPressedHandler, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedHandler,
      style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0.0),
      primary: const Color(0xFF353535),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
 
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFF8F047),
              Color(0xFFFB8D1C),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(),
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}

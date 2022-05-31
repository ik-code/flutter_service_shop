import 'package:flutter/material.dart';
import 'package:playground/utilities/constans.dart';

class OutlineButtonPG extends StatelessWidget {
  final String text;
  final VoidCallback onPressedHandler;

  const OutlineButtonPG(
      {required this.text, required this.onPressedHandler, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressedHandler,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        primary: const Color(0xFFFB8D1C),
        side: const BorderSide(
          width: 1.0,
          color: Color(0xFFFB8D1C),
          style: BorderStyle.solid
          ),
      ),
      child: Text(
        text,
        style: kButtonTextOrangeStyle,
      ),
    );
  }
}

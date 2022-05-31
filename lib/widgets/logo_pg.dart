import 'package:flutter/material.dart';

class LogoPG extends StatelessWidget {
  final String imgFile;
  final double heightMarginTop;

  const LogoPG({required this.imgFile, this.heightMarginTop = 40, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(
          height: heightMarginTop,
        ),
        Image(
          image: AssetImage('images/${imgFile}'),
        ),
      ],
    );
  }
}

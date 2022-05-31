import 'package:flutter/material.dart';


class Exclamation  extends StatelessWidget {
    Exclamation ({
     required this.errorContainerHeight, 
     required this.error, 
     required this.errorText, 
     required this.backgroundColor,
     required this.textColor,
     required this.assetPath,
     Key? key }) : super(key: key);

  double errorContainerHeight = 0.0;
  bool error = true;
  String errorText = '';
  Color backgroundColor;
  Color textColor;
  String assetPath ;

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                height: error ?   errorContainerHeight : 0,
                child: Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.start, 
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 4, left: 4,),
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10), 
                         color:  backgroundColor),
                      child: Row(
                        children: [
                    error 
                    ? const SizedBox( width: 26, height: 26,child: Image( image: AssetImage('images/exclamation.png')),)
                    : const SizedBox()
                    ,
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                        error ?   errorText : ''  ,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFFD32F2F),
                        )) ),
                      ],),
                    ),
                    
                  ],
                ),
              );
  }
}
import 'package:flutter/material.dart';
import 'package:playground/screens/auth_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/widgets/logo_pg.dart';
import 'package:playground/widgets/raised_btn_pg.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundWhitePG,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    LogoPG(
                      imgFile: 'logo_orange_final_screen.png',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Congrats!',
                      style: kBigtitleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Password is updated successfully',
                      style: kSubtitleBlackTextStyle,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              )),
              RaisedButtonPG(
                text: 'Go to Sing in',
                onPressedHandler: () {
                  print('Go to Sing in');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

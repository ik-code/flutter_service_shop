import 'package:flutter/material.dart';
import 'package:playground/screens/registration/stepper_screen.dart';
import 'package:playground/screens/auth_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/widgets/logo_pg.dart';
import 'package:playground/widgets/outlinebutton_pg.dart';
import 'package:playground/widgets/raised_btn_pg.dart';

class SingInSingUpScreen extends StatelessWidget {
  const SingInSingUpScreen({Key? key}) : super(key: key);

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        LogoPG(imgFile: 'playground_logo_orange.png'),
                      ]),
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlineButtonPG(
                        text: 'Sign in',
                        onPressedHandler: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthScreen()),
                          );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'or',
                        style: kSmallTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RaisedButtonPG(
                        text: 'Sing up',
                        onPressedHandler: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StepperScreen()),
                          );
                        }),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

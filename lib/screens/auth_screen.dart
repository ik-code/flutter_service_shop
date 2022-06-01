import 'package:flutter/material.dart';
import 'package:playground/forms/signin_form.dart';
import 'package:playground/utilities/constans.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundWhitePG,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SigninForm(),
          ),
        ));
  }
}

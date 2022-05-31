import 'package:flutter/material.dart';
import 'package:playground/forms/confirm_pass_form.dart';
import 'package:playground/utilities/constans.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = '/reset_password';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: IconButton(
            icon: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Color(0xFFFEFBDA),
                  Color(0xFFFEE9D2),
                ]),
              ),
              child: const Icon(Icons.arrow_back),
            ),
            iconSize: 24,
            color: const Color(0xFF212121),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: const <Widget>[
                SizedBox(
                  width: 24,
                ),
                Text(
                  'Forgot Password',
                  style: kBigtitleTextStyle,
                ),
                SizedBox(height: 80.0),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Create a new password',
                  style: kSubtitleBlackTextStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ConfirmPastForm(),
          ],
        ),
      ),
    );
  }
}

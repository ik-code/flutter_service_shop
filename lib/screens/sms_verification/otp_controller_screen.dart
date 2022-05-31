import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/screens/sms_verification/reset_password_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:pinput/pinput.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;

  const OTPControllerScreen(
      {required this.phone, required this.codeDigits, Key? key})
      : super(key: key);

  @override
  State<OTPControllerScreen> createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  final length = 6;
  static const borderColor = Color.fromRGBO(251, 141, 28, 1);
  static const errorColor = Color.fromRGBO(218, 20, 20, 1);
  static const fillColor = Color.fromRGBO(69, 146, 151, 0.1);

  final defaultPinTheme = PinTheme(
    width: 58,
    height: 50,
    textStyle: kBigtitleTextStyle,
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color.fromRGBO(69, 146, 151, 0.1)),
    ),
  );

  @override
  void initState() {
    super.initState();

    verifyPhoneNumber();
  }

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.codeDigits + widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
              duration: const Duration(seconds: 3),
            ),
          );
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            verificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            verificationCode = vID;
          });
        },
        timeout: const Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
      body: Column(
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
          const SizedBox(height: 56.0),
          Center(
            child: GestureDetector(
              onTap: () {
                verifyPhoneNumber();
              },
              child: Text(
                "Code has been send to ${widget.codeDigits}-${widget.phone}",
                style: kSubtitleOrangeTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Pinput(
              length: length,
              defaultPinTheme: defaultPinTheme,
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: borderColor),
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: borderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: errorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              pinAnimationType: PinAnimationType.none,
              onCompleted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode.toString(),
                          smsCode: pin))
                      .then((value) {
                    if (value.user != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen()));
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid OTP'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

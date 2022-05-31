import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:playground/screens/sms_verification/otp_controller_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/widgets/raised_btn_pg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _dialCodeDigits = "+1";
  final TextEditingController _controller = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();

    super.dispose();
  }

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
      body: SafeArea(
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
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: Text(
                    "Enters valid Phone number to get SMS",
                    style: kSubtitleOrangeTextStyle,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 48,
                child: CountryCodePicker(
                  onChanged: (country) {
                    setState(() {
                      _dialCodeDigits = country.dialCode!;
                    });
                  },
                  initialSelection: "US",
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  favorite: const ["+1", "US", "+44", "UK" "+380", "UA"],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, right: 24, left: 24),
                child: TextFormField(
                  style: kInputTextStyle,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    )
                  ],
                  decoration: InputDecoration(
                    labelText: 'Phone *',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFB8D1C),
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFFB8D1C),
                        )),
                    suffixIcon: Image.asset('images/phone.png'),
                    hintText: "Phone",
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        _dialCodeDigits,
                        style: kInputTextStyle,
                      ),
                    ),
                  ),
                  maxLength: 10,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  controller: _controller,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, right: 24, left: 24, bottom: 24),
                child: RaisedButtonPG(
                    text: 'Send SMS Code',
                    onPressedHandler: () {
                      print(_dialCodeDigits);
                      print(_controller.text);
                      Provider.of<Data>(context, listen: false)
                              .data['phone_number'] =
                          (_dialCodeDigits.substring(1) + _controller.text);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTPControllerScreen(
                                phone: _controller.text,
                                codeDigits: _dialCodeDigits,
                              )));
                    }),
              ),
            ]),
      ),
    );
  }
}

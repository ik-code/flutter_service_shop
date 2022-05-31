import 'dart:async';
import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/screens/registration/stepper_screen.dart';
import 'package:playground/screens/services_getaways/sg_list_sreen.dart';
import 'package:playground/screens/sms_verification/login_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/widgets/logo_pg.dart';
import 'package:playground/widgets/raised_btn_pg.dart';

import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/auth.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _authData = {
    "phone_number": '',
    "password": '',
    'password_confirmation': '',
    'api_personal_access_token': '',
  };

  final _isLoading = false;

  String _dialCodeDigits = "+1";
  String _phone = '';
  String _password = '';
  bool _isPasswordVisible = true;

  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  //RegExp(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$');

  @override
  void initState() {
    super.initState();
    print('initState called');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    _formKey.currentState?.save();

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('Error');
      return;
    }
    print('Form was submitted');
    print('DialCode: $_dialCodeDigits');

    print('Phone: $_phone');
    print('Password: $_password');

    String resbody = await Provider.of<Auth>(context, listen: false)
        .login((_dialCodeDigits.substring(1) + _phone), _password);

    var rb = jsonDecode(resbody);

    if (rb['status'] == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(rb['message'])));

      _authData['api_personal_access_token'] =
          rb['data']['api_personal_access_token'];

      Provider.of<Data>(context, listen: false).updateAccount(_authData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SGListSreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(rb['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(children: <Widget>[
              const LogoPG(
                imgFile: 'playground_logo_orange.png',
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('Sign in to your account', style: kSubtitleTextStyle),
              const SizedBox(
                height: 40,
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
                  favorite: const ["+1", "US", "+380", "UA"],
                ),
              ),
              buildPhone(),
              const SizedBox(
                height: 40,
              ),
              buildPassword(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Change the password?'),
                    style: TextButton.styleFrom(
                      primary: const Color(0xFF919191),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 110,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account?",
                    ),
                    TextButton(
                    child: const Text('Sing up'),
                    style: TextButton.styleFrom(
                      primary:  Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StepperScreen()),
                      );
                    },
                  ),
                  ],
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : RaisedButtonPG(
                        text: 'Sing in',
                        onPressedHandler: () {
                          _submit();
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildPhone() => TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r"[0-9]"),
          )
        ],
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: _passwordFocusNode.hasFocus
                ? const Color(0xFF898A8D)
                : const Color(0xFF898A8D),
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Phone',
          prefix: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Text(
              _dialCodeDigits,
              style: kInputTextStyle,
            ),
          ),
          hintStyle: kInputHintTextStyle,
          errorStyle: kErrorTextStyle,
          labelText: 'Phone *',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFFB8D1C),
              width: 2.0,
            ),
          ),
          suffixIcon: Image.asset('images/phone.png'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color(0xFFFB8D1C),
              )),
        ),
        style: kInputTextStyle,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        focusNode: _phoneFocusNode,
        textInputAction: TextInputAction.next,
        onSaved: (inputPhone) {
          _phone = inputPhone!;
          _authData['phone_number'] =
              _dialCodeDigits.toString().substring(1) + inputPhone.toString();
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a phone number';
          }
          if (!phoneRegex.hasMatch(value)) {
            setState(() {});

            return 'Please enter a valid phone number';
          }
          return null;
        },
      );

  Widget buildPassword() => TextFormField(
        onChanged: (value) => setState(() => _password = value),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: _passwordFocusNode.hasFocus
                ? const Color(0xFF898A8D)
                : const Color(0xFF898A8D),
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Password',
          labelText: 'Password *',
          hintStyle: kInputHintTextStyle,
          errorStyle: kErrorTextStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFFB8D1C),
              width: 2.0,
            ),
          ),
          suffixIcon: IconButton(
            icon: _isPasswordVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: Color(0xFFFB8D1C),
                  )
                : const Icon(Icons.visibility, color: Color(0xFFFB8D1C)),
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: kInputTextStyle,
        obscureText: _isPasswordVisible,
        keyboardType: TextInputType.text,
        focusNode: _passwordFocusNode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
        onSaved: (inputPassword) {
          _password = inputPassword!;
          _authData['password'] = inputPassword.toString();
        },
        onFieldSubmitted: (_) {},
      );
}

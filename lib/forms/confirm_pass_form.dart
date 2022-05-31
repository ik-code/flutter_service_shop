import 'package:flutter/material.dart';
import 'package:playground/screens/sms_verification/congrats_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/widgets/raised_btn_pg.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/auth.dart';

class ConfirmPastForm extends StatefulWidget {
  const ConfirmPastForm({Key? key}) : super(key: key);

  @override
  State<ConfirmPastForm> createState() => _ConfirmPastFormState();
}

class _ConfirmPastFormState extends State<ConfirmPastForm> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  String _password2 = '';
  bool _isPasswordVisible = true;
  bool _isPasswordVisible2 = true;

  final _passwordFocusNode = FocusNode();
  final _passwordFocusNode2 = FocusNode();

  final Map data = {
    'phone_number': '',
    'token': '',
    'password': '',
    'password_confirmation': '',
  };

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _passwordFocusNode2.dispose();
    super.dispose();
  }

  void _saveForm() async {
    _formKey.currentState!.save();

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('Error');
      return;
    }
    print('Form was submitted');
    print('Password: $_password');
    print('Password: $_password2');

    await Provider.of<Auth>(context, listen: false).resetPassword(
        Provider.of<Data>(context, listen: false).data['phone_number'],
        _password,
        _password2,
        Provider.of<Data>(context, listen: false)
            .data['api_personal_access_token']);

    Provider.of<Data>(context, listen: false).data['password'] = _password;
    Provider.of<Data>(context, listen: false).data['password_confirmation'] =
        _password2;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CongratsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    print('build called');

    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.only(top: 0, right: 24, left: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(children: <Widget>[
              buildPassword(),
              const SizedBox(
                height: 40,
              ),
              buildPassword2(),
              const SizedBox(
                height: 40,
              ),
            ]),
            Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                RaisedButtonPG(
                  text: 'Save',
                  onPressedHandler: () {
                    if (_formKey.currentState!.validate()) {
                      print(_password);
                      print(_password2);
                      if (_password.isEmpty || _password2.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please, fill up fields Password and Password Confirm')));
                        print('Please enter password');
                      }
                      if (_password.toString() != _password2.toString()) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Fields Password and Password Confirm don't match")));
                        print(
                            "Fields Password and Password Confirm don't match");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        _saveForm();
                      }
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
        textInputAction: TextInputAction.next,
        obscureText: _isPasswordVisible,
        keyboardType: TextInputType.text,
        focusNode: _passwordFocusNode,
        validator: (inputPassword) {
          print(inputPassword);
          if (inputPassword == null || inputPassword.isEmpty) {
            return 'Please enter a password';
          }
          if (inputPassword.length < 8) {
            return 'Password must be at least 8 characters';
          }

          return null;
        },
        onSaved: (inputPassword) {
          _password = inputPassword!;
          data['password'] = inputPassword.toString();
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode2);
        },
      );

  Widget buildPassword2() => TextFormField(
        onChanged: (inputPassword2) =>
            setState(() => _password2 = inputPassword2),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: _passwordFocusNode2.hasFocus
                ? const Color(0xFF898A8D)
                : const Color(0xFF898A8D),
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Password Confirm',
          labelText: 'Password Confirm*',
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
            icon: _isPasswordVisible2
                ? const Icon(
                    Icons.visibility_off,
                    color: Color(0xFFFB8D1C),
                  )
                : const Icon(Icons.visibility, color: Color(0xFFFB8D1C)),
            onPressed: () =>
                setState(() => _isPasswordVisible2 = !_isPasswordVisible2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: kInputTextStyle,
        textInputAction: TextInputAction.next,
        obscureText: _isPasswordVisible2,
        keyboardType: TextInputType.text,
        focusNode: _passwordFocusNode2,
        validator: (inputPassword2) {
          print(inputPassword2);
          if (inputPassword2 == null || inputPassword2.isEmpty) {
            return 'Please enter a password';
          }
          if (inputPassword2.length < 8) {
            return 'Password must be at least 8 characters';
          }

          return null;
        },
        onSaved: (inputPassword2) {
          _password2 = inputPassword2!;
          data['password_confirmation'] = inputPassword2.toString();
        },
        onFieldSubmitted: (_) {
          _formKey.currentState!.validate();
        },
      );
}

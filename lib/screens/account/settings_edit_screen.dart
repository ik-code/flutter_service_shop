import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/screens/singin_singup_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:playground/utilities/validation.dart';
import 'package:playground/widgets/outlinebutton_pg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SettingsEditScreen extends StatefulWidget {
  const SettingsEditScreen({Key? key}) : super(key: key);

  @override
  State<SettingsEditScreen> createState() => _SettingsEditScreenState();
}

class _SettingsEditScreenState extends State<SettingsEditScreen> {
  String apiPersonalAccessToken = '';
  String dialCodeDigits = "+1";
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _password = '';
  bool _isPasswordVisible = true;

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  //RegExp(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$');

  final Map data = {
    'phone_number': '',
    'token': '',
    'password': '',
    'password_confirmation': '',
  };

  void logout() {
    Provider.of<Data>(context, listen: false).data['password'] = '';
    Provider.of<Data>(context, listen: false).data['password_confirmation'] =
        '';
    Provider.of<Data>(context, listen: false).data['phone_number'] = '';
    Provider.of<Data>(context, listen: false)
        .data['api_personal_access_token'] = '';

    print(
        'Central State after logout: ${Provider.of<Data>(context, listen: false).data}');
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SingInSingUpScreen()));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
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
    //to be sure that you clear up that memory, free up that memory which they occupy and avoid memory leaks!!! Disposing Objects!
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() async {
    _formKey.currentState?.save();

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('Error');
      return;
    }
    print('Form was submitted');
    print('DialCode: $dialCodeDigits');

    print('Phone: $_phone');
    print('Password: $_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundWhitePG,
      appBar: AppBar(
        backgroundColor: kBackGroundWhitePG,
        elevation: 0.0,
        leading: IconButton(
          icon: IconButton(
            icon: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  kArrowAppBarBGArrowGradient1,
                  kArrowAppBarBGArrowGradient2,                  
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
        toolbarHeight: 80,
        title: Row(
          children: [
            const SizedBox(width: 4),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 40,
              color: const Color(0xFF212121),
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 24.0,
          left: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: const [
                    Text(
                      'Settings',
                      style: kBigtitleTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: kGreyPG,
                          )),
                      child: FittedBox(
                          child: Image.network(
                        //_imageUrlController.text,
                        'https://www.shareicon.net/data/128x128/2017/06/21/887379_face_512x512.png',

                        fit: BoxFit.cover,
                      )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z]+|\s"),
                    )
                  ],
                  validator: (firstNameInput) {
                    if (firstNameInput!.length < 2) {
                      return 'First Name must be greater than 1 characters';
                    }
                    if (firstNameInput.isValidName) {
                      return 'Enter valid First Name';
                    }
                    return null;
                  },
                  //controller: firstName,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: _firstNameFocusNode.hasFocus
                          ? const Color(0xFF898A8D)
                          : const Color(0xFF898A8D),
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Image.asset('images/user.png'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'First Name',
                    labelText: 'First Name *',
                    hintStyle: kInputHintTextStyle,
                    errorStyle: kErrorTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFB8D1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: kInputTextStyle,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _firstNameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_lastNameFocusNode);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z]+|\s"),
                    )
                  ],
                  validator: (lastNameInput) {
                    if (lastNameInput!.length < 2) {
                      return 'Last Name must be greater than 1 characters';
                    }
                    if (lastNameInput.isValidName) {
                      return 'Enter valid Last Name';
                    }
                    return null;
                  },
                  // controller: lastName,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: _lastNameFocusNode.hasFocus
                          ? const Color(0xFF898A8D)
                          : const Color(0xFF898A8D),
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Image.asset('images/user.png'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Last Name',
                    labelText: 'Last Name *',
                    hintStyle: kInputHintTextStyle,
                    errorStyle: kErrorTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFB8D1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: kInputTextStyle,
                  //textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                  focusNode: _lastNameFocusNode,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_lastNameFocusNode);
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //controller: email,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: _emailFocusNode.hasFocus
                          ? const Color(0xFF898A8D)
                          : const Color(0xFF898A8D),
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Image.asset('images/envelope.png'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Email',
                    labelText: 'Email *',
                    hintStyle: kInputHintTextStyle,
                    errorStyle: kErrorTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFB8D1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: kInputTextStyle,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phoneFocusNode);
                  },
                  validator: (emailInput) {
                    if (!emailInput!.isValidEmail) {
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: 400,
                  height: 48,
                  child: CountryCodePicker(
                    onChanged: (country) {
                      setState(() {
                        dialCodeDigits = country.dialCode!;
                      });
                    },
                    initialSelection: "US",
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: const ["+1", "US", "+380", "UA"],
                  ),
                ),
                buildPhone(),
                const SizedBox(height: 10.0),
                buildPassword(),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: OutlineButtonPG(text: 'Edit', onPressedHandler: () {}),
                )
              ]),
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
              dialCodeDigits,
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
          // IconButton(
          //   icon: const Icon(
          //     Icons.phone,
          //     color: Color(0xFFFB8D1C),
          //   ),
          //   onPressed: () {},
          // ),
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
          data['phone_number'] =
              dialCodeDigits.toString().substring(1) + inputPhone.toString();
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
          data['password'] = inputPassword.toString();
        },
        onFieldSubmitted: (_) {},
      );
}

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/screens/registration/stepper_screen.dart';
import 'package:playground/screens/services_getaways/add_review/add_review_screen.dart';
import 'package:playground/screens/services_getaways/services/category_service_single_post_screen.dart';
import 'package:playground/screens/services_getaways/sg_list_sreen.dart';
import 'package:playground/screens/singin_singup_screen.dart';
import 'package:playground/screens/auth_screen.dart';
import 'package:playground/screens/sms_verification/login_screen.dart';
import 'package:playground/screens/sms_verification/congrats_screen.dart';
import 'package:playground/screens/sms_verification/reset_password_screen.dart';
import 'package:playground/utilities/constans.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'screens/services_getaways/services/service_category_post_list_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
 WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Manrope',
              primarySwatch: Colors.grey,
              unselectedWidgetColor: kGreyPg,
            ),
            home: const SingInSingUpScreen(),
            // const CategoryServiceSinglePostScreen(),
            //const ServiceCategoryPostListScreen(serviceCatPostList: null,),

            // const SGListSreen(),
            //---SMS Verification---
            //const LoginScreen(),
            // const ResetPasswordScreen(),
            // const CongratsScreen(),
            routes: {
              AuthScreen.routeName: (ctx) => const AuthScreen(),
              StepperScreen.routeName: (ctx) => const StepperScreen(),
              ResetPasswordScreen.routeName: (ctx) =>
                  const ResetPasswordScreen(),
              ServiceCategoryPostListScreen.routeName: (ctx) =>
                  const ServiceCategoryPostListScreen(),
              CategoryServiceSinglePostScreen.routeName: (ctx) =>
                  const CategoryServiceSinglePostScreen(),
              AddReviewScreen.routeName: (ctx) => const AddReviewScreen(),
            }),
      ),
    );
  }
}

class Data extends ChangeNotifier {
  Map data = {
    'first_name': '',
    'last_name': '',
    'avatar':
        'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png',
    'email': '',
    'password': '',
    'password_confirmation': '',
    'phone_number': '',
    'api_personal_access_token': '',
  };

  void updateAccount(input) {
    data = input;
    print('Main Central State: ${data}');
    notifyListeners();
  }
}

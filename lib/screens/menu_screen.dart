import 'package:flutter/material.dart';
import 'package:playground/screens/account/settings_edit_screen.dart';
import 'package:playground/utilities/constans.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundWhitePG,
      appBar: AppBar(
        backgroundColor: kBackGroundWhitePG,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 40,
              color: const Color(0xFF212121),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Image(
                  image: AssetImage('images/badge.png'),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Apply to become\n a Service Provider',
                  style: kBigtitleTextStyle,
                ),
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Image(
                  image: AssetImage('images/calendar.png'),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Monthly Availability',
                  style: kBigtitleTextStyle,
                ),
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingsEditScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Image(
                  image: AssetImage('images/settings.png'),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Settings',
                  style: kBigtitleTextStyle,
                ),
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

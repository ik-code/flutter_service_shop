import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:playground/screens/menu_screen.dart';
import 'package:playground/screens/services_getaways/getaways/getaway_list_screen.dart';
import 'package:playground/screens/services_getaways/services/services_category_list_screen.dart';
import 'package:playground/widgets/logo_pg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../main.dart';

class SGListSreen extends StatefulWidget {
  const SGListSreen({Key? key}) : super(key: key);

  @override
  State<SGListSreen> createState() => _SGListSreenState();
}

class _SGListSreenState extends State<SGListSreen> {
  final Uri _urlGetways =
      Uri.parse('https://lav.playground.wdscode.guru/api/getaways-list');
  final Uri _urlServicesCatList = Uri.parse(
      'https://lav.playground.wdscode.guru/api/service-categories-list');

  dynamic _responseDataGetways;
  dynamic _responseDataServicesCatList;

  bool _isLoadingGetaways = false;
  bool _isLoadingServices = false;

  Future<void> _getDataGetways(urlGetways) async {
    _isLoadingGetaways = true;
    final response = await http.get(urlGetways, headers: {
      'Authorization':
          // 'Uk_9YrTcBzNrE8e4riECrNRikqWOtI9iyoljQ1GnCMtSzaRjV1wHWBh8OvZa'
          Provider.of<Data>(context, listen: false)
              .data['api_personal_access_token']
    });

    final resBody = jsonDecode(response.body);

    if (resBody['status'] == 0) {
      _isLoadingGetaways = true;
    } else {
      _isLoadingGetaways = false;
      setState(() {
        _responseDataGetways = resBody;
      });
    }
  }

  Future<void> _getDataServicesCatList(urlServicesCatList) async {
    _isLoadingServices = true;
    final response = await http.get(urlServicesCatList, headers: {
      'Authorization':
          // 'Uk_9YrTcBzNrE8e4riECrNRikqWOtI9iyoljQ1GnCMtSzaRjV1wHWBh8OvZa'
          Provider.of<Data>(context, listen: false)
              .data['api_personal_access_token']
    });

    final resBody = jsonDecode(response.body);

    if (resBody['status'] == 0) {
      _isLoadingServices = true;
    } else {
      _isLoadingServices = false;
      setState(() {
        _responseDataServicesCatList = resBody;
      });
    }
  }

  @override
  void initState() {
    _getDataGetways(_urlGetways);
    _getDataServicesCatList(_urlServicesCatList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const LogoPG(
                heightMarginTop: 0, imgFile: 'playground_logo_orange.png'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 40,
              color: const Color(0xFF212121),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF4E9),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ButtonsTabBar(
                      height: 54,
                      contentPadding:
                          const EdgeInsets.only(right: 56, left: 56),
                      backgroundColor: const Color(0xFFFB8D1C),
                      unselectedBackgroundColor: const Color(0xFFFFF4E9),
                      unselectedLabelStyle:
                          const TextStyle(color: Color(0xFF979797)),
                      radius: 100,
                      labelStyle: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Services',
                        ),
                        Tab(
                          text: 'Getways',
                        ),
                      ]),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 24.0, left: 24.0, top: 24.0),
                      child: (_isLoadingGetaways ||
                              _responseDataServicesCatList == null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                  Center(child: CircularProgressIndicator()),
                                ])
                          : ServicesCategoryListScreen(
                              servicesCatList: _responseDataServicesCatList,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 24.0, left: 24.0, top: 24.0),
                      child: (_isLoadingGetaways ||
                              _responseDataGetways == null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                  Center(child: CircularProgressIndicator()),
                                ])
                          : GetawayListScreen(
                              getawaysList: _responseDataGetways,
                            ),
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}

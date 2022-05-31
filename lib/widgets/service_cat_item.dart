import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:playground/screens/services_getaways/services/service_category_post_list_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utilities/constans.dart';
import 'package:http/http.dart' as http;

class ServiceCatItem extends StatefulWidget {
  final int id;
  final String title;
  final String image;
  final String? termsAndConditions;
  final String createdAt;
  final String updatedAt;

  const ServiceCatItem(this.id, this.title, this.image, this.termsAndConditions,
      this.createdAt, this.updatedAt,
      {Key? key})
      : super(key: key);

  @override
  State<ServiceCatItem> createState() => _ServiceCatItemState();
}

class _ServiceCatItemState extends State<ServiceCatItem> {
  bool singleTap = true;

  @override
  Widget build(BuildContext context) {
    final Uri _urlServiceCatPostList = Uri.parse(
        'https://lav.playground.wdscode.guru/api/service-category-post-list');

    Future<void> _getDataUrlServiceCatPosttListById(catId) async {
      final response = await http.post(_urlServiceCatPostList,
          body: json.encode({
            "category_id": catId,
          }),
          headers: {
            'Authorization':
                // 'ML-4hgqBQ5vOwbpM2m39sRZbfQLtMVW-ZWwbj7AYMrxq1cPfejxc70-Dw_NM'
                Provider.of<Data>(context, listen: false)
                    .data['api_personal_access_token']
          });

      final resBody = jsonDecode(response.body);

      if (resBody['status'] == 0) {
        // print(
        //     ' Status 0          resServiceCatPostList: ${resBody['data']['services']}');
      } else {
        // print(
        //     ' Status 1          resServiceCatPostList: ${resBody['data']['services']}');
        setState(() {
          singleTap = true;
        });
        Navigator.pushNamed(context, ServiceCategoryPostListScreen.routeName,
            arguments: {
              "dataItem": resBody['data']['services'],
              "category": widget.title
            });
      }
    }

    return GestureDetector(
      onTap: (() {
        print('Services id: ${widget.id}');
        if (singleTap) {
          _getDataUrlServiceCatPosttListById(widget.id);

          setState(() {
            singleTap = false;
          });
        } // update bool
      }),
      child: Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.3),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ClipRRect(
            child: Container(
              height: 119,
              width: double.infinity,
              child: Image.network(
                widget.image.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(widget.title, style: kServicesCatListTitleBlackStyle)
        ]),
      ),
    );
  }
}

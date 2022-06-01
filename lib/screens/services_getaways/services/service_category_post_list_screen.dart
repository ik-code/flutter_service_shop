import 'package:flutter/material.dart';
import 'package:playground/utilities/constans.dart';

import '../../../widgets/service_category_post_list_item.dart';
import '../../menu_screen.dart';

class ServiceCategoryPostListScreen extends StatelessWidget {
  static const routeName = '/service-category-post-list';

  const ServiceCategoryPostListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    bool _isLoadingServiceCategoryPostList = true;

    dynamic dataItem = arguments['dataItem'];
    dynamic category = arguments['category'];

    if (dataItem.isEmpty) {
      _isLoadingServiceCategoryPostList = true;
    } else {
      _isLoadingServiceCategoryPostList = false;
    }

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
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
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
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    category,
                    style: kBigtitleTextStyle,
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
              Expanded(
                child: _isLoadingServiceCategoryPostList
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                // Text('arguments[dataItem]: ${dataItem}'),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dataItem.length,
                                  itemBuilder: (ctx, i) =>
                                      ServiceCategoryPostListItem(
                                    dataItem[i]['id'],
                                    dataItem[i]['title'],
                                    dataItem[i]['price'].toDouble(),
                                    dataItem[i]['fee'],
                                    dataItem[i]['photos'],
                                    dataItem[i]['description'],
                                    dataItem[i]['date_time'],
                                    dataItem[i]['duration_hours'],
                                    dataItem[i]['duration_minutes'],
                                    dataItem[i]['payment_type'].toString(),
                                    dataItem[i]['created_by_id'],
                                    dataItem[i]['created_at'],
                                    dataItem[i]['updated_at'],
                                    dataItem[i]['excerpt'],
                                    dataItem[i]['pivot'],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

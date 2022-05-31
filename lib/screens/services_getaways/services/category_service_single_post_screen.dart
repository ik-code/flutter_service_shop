import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:playground/screens/services_getaways/add_review/add_review_screen.dart';
import 'package:playground/widgets/outlinebutton_pg.dart';
import 'package:playground/widgets/raised_btn_pg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../utilities/constans.dart';
import '../../menu_screen.dart';
import '../../../widgets/accordion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class CategoryServiceSinglePostScreen extends StatefulWidget {
  static const routeName = '/category-service-single-post-screen';

  const CategoryServiceSinglePostScreen({Key? key}) : super(key: key);

  @override
  State<CategoryServiceSinglePostScreen> createState() =>
      _CategoryServiceSinglePostScreenState();
}

class _CategoryServiceSinglePostScreenState
    extends State<CategoryServiceSinglePostScreen> {
  var categoryServiceSinglePostId;
  dynamic _responseCategoryServiceSinglePost;
  var _ratingValue;
  bool _isLoadingCategoryServiceSinglePost = true;
  bool _dataIsLoaded = false;
  List<String> imgList = [];

  final Uri _urlCategoryServiceSinglePost = Uri.parse(
      'https://lav.playground.wdscode.guru/api/category-service-single-post');

  Future<void> _getDataCategoryServiceSinglePost(
      urlCategoryServiceSinglePost) async {
    print('categoryServiceSinglePostId: $categoryServiceSinglePostId');

    final response = await http.post(urlCategoryServiceSinglePost,
        body: jsonEncode({"service_id": categoryServiceSinglePostId}),
        headers: {
          'Authorization':
              // 'Uk_9YrTcBzNrE8e4riECrNRikqWOtI9iyoljQ1GnCMtSzaRjV1wHWBh8OvZa'
              Provider.of<Data>(context, listen: false)
                  .data['api_personal_access_token']
        });

    final resBody = jsonDecode(response.body);
    print('RESPONSE BODY category-service-single-post: ${response.body}');

    if (resBody != null) {
      setState(() {
        _dataIsLoaded = true;
      });
    } else {
      setState(() {
        _dataIsLoaded = false;
      });
    }

    if (resBody['status'] == 0) {
      setState(() {
        _isLoadingCategoryServiceSinglePost = true;
        _responseCategoryServiceSinglePost = resBody['data']['service'];
        imgList = _responseCategoryServiceSinglePost['photos'] == null
            ? []
            : List.from(_responseCategoryServiceSinglePost['photos']);
      });
      print(
          '_responseCategoryServiceSinglePost: $_responseCategoryServiceSinglePost');
    } else {
      setState(() {
        _isLoadingCategoryServiceSinglePost = false;
        _responseCategoryServiceSinglePost = resBody['data']['service'];
        imgList = _responseCategoryServiceSinglePost['photos'] == null
            ? []
            : List.from(_responseCategoryServiceSinglePost['photos']);
      });
      setState(() {});
      print(
          '_responseCategoryServiceSinglePost: $_responseCategoryServiceSinglePost');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    setState(() {
      categoryServiceSinglePostId = arguments['categoryServiceSinglePostId'];
    });

    if (!_dataIsLoaded) {
      _getDataCategoryServiceSinglePost(_urlCategoryServiceSinglePost);
    }

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
      body: _isLoadingCategoryServiceSinglePost &&
              _responseCategoryServiceSinglePost == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 0,
                          ),
                          Row(
                            children: [
                              const Text(
                                'created by',
                                style: kCatServiceSinglePostAuthorGreyStyle,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _responseCategoryServiceSinglePost['created_by']
                                    ['name'],
                                style: kCatServiceSinglePostAuthorOrangeStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          imgList == []
                              ? const SizedBox(
                                  height: 190,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(height: 190.0),
                                  items: imgList.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 190,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              i,
                                              fit: BoxFit.cover,
                                              height: 190,
                                              width: double.infinity,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            _responseCategoryServiceSinglePost['title'],
                            style: kCatServiceSinglePostTitleBlackStyle,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                  DateFormat.yMMMMd('en_US').format(
                                      DateTime.parse(
                                          _responseCategoryServiceSinglePost[
                                              'date_time'])),
                                  style: kCatServiceSinglePostTimeGreyStyle),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Duration ' +
                                    _responseCategoryServiceSinglePost[
                                            'duration_hours']
                                        .toString() +
                                    'h ' +
                                    _responseCategoryServiceSinglePost[
                                            'duration_minutes']
                                        .toString() +
                                    'm',
                                style: kCatServiceSinglePostTimeGreyStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            _responseCategoryServiceSinglePost['excerpt'],
                            style: kCatServiceSinglePostTextBlackStyle,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Accordion(
                              title: 'Read More',
                              content: _responseCategoryServiceSinglePost[
                                  'description']),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFF7F7F7),
                        ],
                      )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$ ' +
                                      _responseCategoryServiceSinglePost[
                                              'price']
                                          .toString(),
                                  style: kGetawaysPriceStyle,
                                ),
                                const Text(
                                  ' / per day',
                                  style: kCatServiceSinglePostTextBlackStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            RaisedButtonPG(
                                text: 'Book Service', onPressedHandler: () {}),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // const SizedBox(
                    //   height: 24,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 24),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFF7F7F7),
                        ],
                      )),
                      child: Card(
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(36),
                                topRight: Radius.circular(36))),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 24.0, left: 24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24.0, bottom: 8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: 'Reviews - ',
                                          style:
                                              kCatServiceSinglePostReviewsTitleBlackStyle,
                                        ),
                                        TextSpan(
                                          text:
                                              _responseCategoryServiceSinglePost[
                                                  'title'],
                                          style:
                                              kCatServiceSinglePostReviewsTitleGreyStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    RatingBar(
                                      ignoreGestures: true,
                                      initialRating:
                                          (_responseCategoryServiceSinglePost[
                                                  'rate_of_service'])
                                              .toDouble(),
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemSize: 28.0,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star_rate_rounded,
                                          color: kOrangePG,
                                          size: 12.0,
                                        ),
                                        half: const Icon(
                                          Icons.star_half_rounded,
                                          color: kOrangePG,
                                        ),
                                        empty: const Icon(
                                          Icons.star_border_rounded,
                                          color: kOrangePG,
                                        ),
                                      ),
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                        setState(() {
                                          _ratingValue = rating;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      (_responseCategoryServiceSinglePost[
                                              'rate_of_service'])
                                          .toStringAsFixed(2),
                                      style:
                                          kCatServiceSinglePostReviewsRaitingNumberStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: OutlineButtonPG(
                                        text: 'Leave feedback',
                                        onPressedHandler: () {
                                          Navigator.pushNamed(context,
                                              AddReviewScreen.routeName,
                                              arguments: {
                                                "service_id":
                                                    _responseCategoryServiceSinglePost[
                                                        'id'],
                                              });
                                        })),
                                const SizedBox(height: 40,),
                                Column(
                                  children: [
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            _responseCategoryServiceSinglePost[
                                                    'reviews']
                                                .length,
                                        itemBuilder: (ctx, i) {
                                          if (_responseCategoryServiceSinglePost[
                                                  'reviews'][i]['status'] ==
                                              'approved') {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _responseCategoryServiceSinglePost[
                                                          'reviews'][i]
                                                      ['created_by']['name'],
                                                  style:
                                                      kCatServiceSinglePostReviewsAuthorNumberStyle,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  DateFormat.yMMMMd('en_US')
                                                      .format(DateTime.parse(
                                                          _responseCategoryServiceSinglePost[
                                                                  'reviews'][i]
                                                              ['created_at'])),
                                                  style:
                                                      kCatServiceSinglePostTimeGreyStyle,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                RatingBar(
                                                  ignoreGestures: true,
                                                  initialRating:
                                                      (_responseCategoryServiceSinglePost[
                                                                  'reviews'][i]
                                                              ['rate'])
                                                          .toDouble(),
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: false,
                                                  itemCount: 5,
                                                  itemSize: 28.0,
                                                  ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                      Icons.star_rate_rounded,
                                                      color: kOrangePG,
                                                      size: 12.0,
                                                    ),
                                                    half: const Icon(
                                                      Icons.star_half_rounded,
                                                      color: kOrangePG,
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star_border_rounded,
                                                      color: kOrangePG,
                                                    ),
                                                  ),
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.0),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                    setState(() {
                                                      _ratingValue = rating;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  _responseCategoryServiceSinglePost[
                                                      'reviews'][i]['text'],
                                                  style:
                                                      kCatServiceSinglePostTextBlackStyle,
                                                ),
                                                const Divider(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                                  height: 40,
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

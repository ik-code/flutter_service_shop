import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../utilities/constans.dart';
import '../../../widgets/raised_btn_pg.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  static const routeName = '/add-review';

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  var _feedback = '';
  var _rating = 0.0;
  final _formKey = GlobalKey<FormState>();
  var _serviceId;

  final Uri _urlAddServiceReview =
      Uri.parse('https://lav.playground.wdscode.guru/api/service-review-add');

  Future<void> _AddServicesReview(urlAddServiceReview, serviceId) async {
    //_isLoadingServices = true;
    final response = await http.post(urlAddServiceReview,
        body: jsonEncode({"id": serviceId, "rate": _rating, "text": _feedback}),
        headers: {
          'Authorization':
              // 'Uk_9YrTcBzNrE8e4riECrNRikqWOtI9iyoljQ1GnCMtSzaRjV1wHWBh8OvZa'
              Provider.of<Data>(context, listen: false)
                  .data['api_personal_access_token']
        });

    final resBody = jsonDecode(response.body);
    print('Server Status AddReview: $resBody');

    if (resBody['status'] == 0) {
      print('Status 0 ResBody AddReview: $resBody');
    } else {
      print('Status 1 ResBody AddReview: $resBody');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    setState(() {
      _serviceId = arguments['service_id'];
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Leave feedback',
              style: kCatServiceSinglePostReviewsTitleBlackStyle,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 30,
              color: const Color(0xFF212121),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  RatingBar(
                    ignoreGestures: false,
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 40.0,
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
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    onRatingUpdate: (rating) {
                      if (rating == 0.0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please, choose Raiting for this one from 1 to 5 stars')),
                        );
                      }

                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, right: 24, left: 24),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      _feedback = value;
                    }),
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: kAddReviewsInputTextStyle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(18.0),
                      hintText: 'Your text here',
                      hintStyle: kAddReviewsHintStyle,
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
                    ),
                    validator: (value) {
                      return value!.length < 8
                          ? 'Feedback must be at least 8 characters'
                          : null;
                    },

                    // focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.text,
                    // controller: _controller,
                  ),
                ),
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, right: 24, left: 24, bottom: 24),
                child: RaisedButtonPG(
                    text: 'Leave feedback',
                    onPressedHandler: () {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        print('Error');
                        return;
                      }
                      if (_rating == 0.0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please, choose Raiting for this one from 1 to 5 stars')),
                        );
                        return;
                      }
                      if (_rating > 0.0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Your raiting is $_rating. Feedback was sent to admin.')),
                        );

                        print(_feedback);
                        print(_rating);
                        print('Service ID: $_serviceId');
                        _AddServicesReview(_urlAddServiceReview, _serviceId);
                        Navigator.of(context).pop();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

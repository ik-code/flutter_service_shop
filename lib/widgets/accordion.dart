import 'package:flutter/material.dart';
import 'package:playground/utilities/constans.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 0.0,
      child: Column(children: [
        _showContent
            ? Container(
                child: Text(
                  widget.content,
                  style: kCatServiceSinglePostTextBlackStyle,
                ),
              )
            : Container(),
        const SizedBox(
          height: 16,
        ),
        Text(
          _showContent ? 'Less' : widget.title,
          style: kCatServiceSinglePostSubTitleOrangeStyle,
        ),
        Row(children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 12.0),
                child: const Divider(
                  color: kOrangePG,
                  height: 0,
                )),
          ),
          Container(
            height: 20,
            child: IconButton(
              iconSize: 30,
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                _showContent
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: kOrangePG,
              ),
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 12.0, right: 10.0),
                child: const Divider(
                  color: kOrangePG,
                  height: 0,
                )),
          ),
        ]),
      ]),
    );
  }
}

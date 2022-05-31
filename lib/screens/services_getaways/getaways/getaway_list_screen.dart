import 'package:flutter/material.dart';
import '../../../utilities/constans.dart';
import '../../../widgets/getaway_item.dart';

class GetawayListScreen extends StatelessWidget {
  final getawaysList;

  const GetawayListScreen({Key? key, required this.getawaysList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataItem = getawaysList["data"]["getaways"];

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          const Text(
              'Welcome to Playground. Adults have more fun here! Book your ideal play date by choosing who will watch your children, getting your makeup done on demand, hiring a driver so you don’t need to worry about anything, book an experience or a yacht rental.',
              style: kGetawaysTextBlackStyle),
          const SizedBox(
            height: 24,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataItem.length,
            itemBuilder: (ctx, i) => GetawayItem(
              dataItem[i]['id'],
              dataItem[i]['title'],
              dataItem[i]['price'].toDouble(),
              dataItem[i]['fee'],
              dataItem[i]['deposit'],
              dataItem[i]['pay_in_parts'],
              dataItem[i]['images'],
              dataItem[i]['description'],
              dataItem[i]['date_time'],
              dataItem[i]['duration_hours'],
              dataItem[i]['duration_minutes'],
              dataItem[i]['payment_type'].toString(),
              dataItem[i]['payment_parts_amount'],
              dataItem[i]['terms_and_conditions'],
              dataItem[i]['created_by_id'],
              dataItem[i]['created_at'],
              dataItem[i]['updated_at'],
              dataItem[i]['excerpt'],
            ),
          )
        ],
      ),
    );
  }
}

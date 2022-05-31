import 'package:flutter/material.dart';
import 'package:playground/widgets/service_cat_item.dart';
import '../../../utilities/constans.dart';

class ServicesCategoryListScreen extends StatelessWidget {
  final servicesCatList;
  const ServicesCategoryListScreen({Key? key, required this.servicesCatList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataItem = servicesCatList["data"]["services_categories"];

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
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataItem.length,
            itemBuilder: (ctx, i) => ServiceCatItem(
              dataItem[i]['id'],
              dataItem[i]['title'],
              dataItem[i]['image'],
              dataItem[i]['terms_and_conditions'],
              dataItem[i]['created_at'],
              dataItem[i]['updated_at'],
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

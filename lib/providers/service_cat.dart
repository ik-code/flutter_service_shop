import 'package:flutter/foundation.dart';

class ServiceCat with ChangeNotifier {
  final int id;
  final String title;
  final String image;
  final String termsAndConditions;
  final String createdAt;
  final String updatedAt;

  ServiceCat({
    required this.id,
    required this.title,
    required this.image,
    required this.termsAndConditions,
    required this.createdAt,
    required this.updatedAt,
  });
}

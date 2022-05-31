import 'package:flutter/foundation.dart';

class Getaway with ChangeNotifier {
  final int id;
  final String title;
  final String price;
  final String fee;
  final double deposit;
  final int payInParts;
  final List<dynamic> images;
  final String description;
  final String dateTime;
  final int durationHours;
  final int durationMinutes;
  final String paymentType;
  final int paymentPartsAmount;
  final String termsAndConditions;
  final int createdById;
  final String createdAt;
  final String updatedAt;
  final String excerpt;

  Getaway({
    required this.id,
    required this.title,
    required this.price,
    required this.fee,
    required this.deposit,
    required this.payInParts,
    required this.images,
    required this.description,
    required this.dateTime,
    required this.durationHours,
    required this.durationMinutes,
    required this.paymentType,
    required this.paymentPartsAmount,
    required this.termsAndConditions,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    required this.excerpt,
  });
}

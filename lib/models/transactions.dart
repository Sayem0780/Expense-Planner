import 'package:flutter/foundation.dart';
class Transaction{
  late String id;
  late String title;
  late dynamic amaunt;
  late DateTime dateTime;

  Transaction({
    required this.id,
    required this.title,
    required this.amaunt,
    required this.dateTime,
  });

}
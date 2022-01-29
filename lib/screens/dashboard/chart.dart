import 'package:cloud_firestore/cloud_firestore.dart';

class ChartData {
  final Timestamp month;
  final int income;
  ChartData({required this.month, required this.income});
  ChartData.fromMap(Map<String, dynamic> dataMap)
      : month = dataMap['date'],
        income = dataMap['profit'];
}

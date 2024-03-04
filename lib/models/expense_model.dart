import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final String title;
  final DateTime dateTime;
  final String cost;
  final IconData icon;
  ExpenseModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.cost,
    this.icon = Icons.access_alarm,
  });
}

class ExpensesList {
  List<ExpenseModel> _expenseModel = [
    ExpenseModel(
      id: "id1",
      title: "Yangi kutob",
      dateTime: DateTime.now(),
      cost: "45,000",
    ),
    ExpenseModel(
      id: "id2",
      title: "Sumka",
      dateTime: DateTime.now(),
      cost: "250,000",
      icon: Icons.shopping_bag,
    ),
    ExpenseModel(
      id: "id3",
      title: "Abet",
      dateTime: DateTime.now(),
      cost: "55,000",
      icon: Icons.lunch_dining,
    ),
    ExpenseModel(
      id: "id4",
      title: "Yangi kutob",
      dateTime: DateTime.now(),
      cost: "45,000",
    ),
  ];

  get expenseList => _expenseModel;
}

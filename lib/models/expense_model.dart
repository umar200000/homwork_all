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
      id: "1",
      title: "Yangi kutob",
      dateTime: DateTime.now(),
      cost: "45,000",
    ),
    ExpenseModel(
      id: "2",
      title: "Sumka",
      dateTime: DateTime.now(),
      cost: "250,000",
      icon: Icons.shopping_bag,
    ),
    ExpenseModel(
      id: "3",
      title: "Abet",
      dateTime: DateTime.now(),
      cost: "55,000",
      icon: Icons.lunch_dining,
    ),
    ExpenseModel(
      id: "4",
      title: "Yangi kutob",
      dateTime: DateTime.now(),
      cost: "45,000",
    ),
  ];

  get expenseList => _expenseModel;
  setAddItem(String title, DateTime time, String sum) {
    int index = int.parse(_expenseModel[_expenseModel.length - 1].id) + 1;
    _expenseModel.add(
        ExpenseModel(id: "$index", title: title, dateTime: time, cost: sum));
  }
}

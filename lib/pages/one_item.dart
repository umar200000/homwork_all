import 'package:flutter/material.dart';
import 'package:homework_all/models/expense_model.dart';
import 'package:intl/intl.dart';

class OneItem extends StatelessWidget {
  final ExpenseModel expenseModel;
  const OneItem(this.expenseModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        expenseModel.icon,
        size: 30,
      ),
      title: Text(
        expenseModel.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(DateFormat("d-MMMM,y").format(expenseModel.dateTime)),
      trailing: Text(
        "${expenseModel.cost} so'm",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

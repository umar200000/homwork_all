import 'package:flutter/material.dart';
import 'package:homework_all/pages/one_item.dart';

import '../models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> list;
  const ExpenseList(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(55),
          ),
          color: Colors.white,
        ),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 30),
          itemBuilder: (context, index) {
            return OneItem(list[index]);
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}

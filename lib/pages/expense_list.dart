import 'package:flutter/material.dart';
import 'package:homework_all/pages/one_item.dart';

import '../models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> list;
  final void Function(String id) removeExpense;
  const ExpenseList(this.list, this.removeExpense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 90),
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(55),
            ),
            color: Colors.white,
          ),
          child: list.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.only(top: 30),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      resizeDuration: Duration(seconds: 1),
                      movementDuration: Duration(seconds: 3),
                      key: ValueKey<ExpenseModel>(list[index]),
                      child: OneItem(list[index]),
                      onDismissed: (DismissDirection direction) {
                        removeExpense(list[index].id);
                      },
                      background: Container(
                        padding: EdgeInsets.only(right: 15),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  itemCount: list.length,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Xarajatlar yo'q",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/wallet.png",
                      height: 200,
                    ),
                  ],
                ),
        ));
  }
}

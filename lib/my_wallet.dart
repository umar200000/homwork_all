import 'package:flutter/material.dart';
import 'package:homework_all/pages/bottom_sheet.dart';
import 'package:homework_all/pages/expense_list.dart';
import 'package:homework_all/pages/month_controller.dart';
import 'package:homework_all/pages/progres_bar.dart';
import 'package:homework_all/pages/spent_money.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'models/expense_model.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  DateTime dateTime = DateTime.now();
  ExpensesList expenseList = ExpensesList();

  void pickMonth(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024, 12),
    ).then((value) {
      setState(() {
        if (value != null) dateTime = value;
      });
    });
  }

  void lastMonth() {
    setState(() {
      if (dateTime.year == 2023 && dateTime.month == 1) return;
      dateTime = DateTime(dateTime.year, dateTime.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      if (dateTime.year == 2024 && dateTime.month == 12) return;
      dateTime = DateTime(dateTime.year, dateTime.month + 1);
    });
  }

  void showBottomWindow(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return BottomSheet1(addNewExpense);
        });
  }

  void addNewExpense(String title, DateTime time, String sum) {
    setState(() {
      expenseList.setAddItem(title, time, sum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Wallet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MonthController(dateTime, pickMonth),
          SizedBox(
            height: 20,
          ),
          SpentMoney(lastMonth, nextMonth, dateTime),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                ProgressBar(),
                ExpenseList(expenseList.expenseList),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomWindow(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

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

class _MyWalletState extends State<MyWallet> with WidgetsBindingObserver {
  DateTime dateTime = DateTime.now();
  ExpensesList expenseList = ExpensesList();
  TextEditingController textEditingController = TextEditingController();
  String budget = "";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    textEditingController.text = "1 000 000";
    budget = "1 000 000";
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
        isScrollControlled: true,
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

  String spentMoneyAmount() {
    int sum = 0;
    List<ExpenseModel> list = expenseList.getListByTime(dateTime);
    for (var element in list) {
      sum += int.parse(element.cost.replaceAll(",", ""));
    }
    return sum.toString();
  }

  String moneyFormat(String str) {
    String s = "";
    int b = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (b == 3) {
        s += " ";
        b = 0;
      }
      s += str[i];
      b++;
    }
    return s.split("").reversed.join();
  }

  void removeExpense(String id) {
    setState(() {
      expenseList.deleteExpense(id);
    });
  }

  void changeBudget(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      textEditingController.text =
                          moneyFormat(text.replaceAll(" ", ""));
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Oylik byudjet muqdori"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          textEditingController.text = budget;
                          Navigator.pop(context);
                        },
                        child: const Text("BEKOR QILISH")),
                    ElevatedButton(
                        onPressed: () {
                          if (textEditingController.text.isEmpty) {
                            return;
                          }
                          setState(() {
                            budget = textEditingController.text;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("KIRITISH"))
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Wallet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          MonthController(dateTime, pickMonth),
          const SizedBox(
            height: 20,
          ),
          SpentMoney(lastMonth, nextMonth, dateTime, spentMoneyAmount()),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                ProgressBar(int.parse(spentMoneyAmount()), changeBudget,
                    budget.replaceAll(" ", ",")),
                ExpenseList(expenseList.getListByTime(dateTime), removeExpense),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomWindow(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

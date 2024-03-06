import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int spentMoneyAmount;
  final void Function(BuildContext context) changeBudget;
  final String budget;
  const ProgressBar(this.spentMoneyAmount, this.changeBudget, this.budget,
      {super.key});

  fixProgress() {
    String s = (100 * spentMoneyAmount / int.parse(budget.replaceAll(",", "")))
        .toString();
    int index = s.indexOf(".");
    if (int.parse(s.substring(index + 1)) > 0) {
      return 100 * spentMoneyAmount / int.parse(budget.replaceAll(",", ""));
    }
    return (100 * spentMoneyAmount / int.parse(budget.replaceAll(",", "")))
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 238, 251, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(55)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Oylik byudjet: "),
              TextButton.icon(
                onPressed: () {
                  changeBudget(context);
                },
                icon: Icon(
                  Icons.edit,
                  size: 15,
                ),
                label: Text(
                  "$budget so'm",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              Expanded(
                  child: Container(
                height: 1,
              )),
              Text(fixProgress() > 100
                  ? "100%"
                  : fixProgress().toString().contains(".")
                      ? "${fixProgress().toStringAsFixed(1)}%"
                      : "${fixProgress()}%"),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              heightFactor: 2,
              widthFactor: fixProgress() <= 100 ? fixProgress() / 100 : 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue, spreadRadius: -2, blurRadius: 15)
                    ],
                    gradient: LinearGradient(colors: [
                      fixProgress() <= 100 ? Colors.blue : Colors.red,
                      fixProgress() <= 100 ? Colors.blue : Colors.red,
                      fixProgress() <= 100
                          ? Colors.blue.shade100
                          : Colors.red.shade100,
                      fixProgress() <= 100 ? Colors.blue : Colors.red,
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}

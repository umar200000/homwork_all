import 'package:flutter/material.dart';

class SpentMoney extends StatelessWidget {
  final void Function() lastMonth;
  final void Function() nextMonth;
  final DateTime dateTime;
  final String sum;
  const SpentMoney(this.lastMonth, this.nextMonth, this.dateTime, this.sum,
      {super.key});

  String moneyFormat() {
    String s = "";
    int b = 0;
    for (int i = sum.length - 1; i >= 0; i--) {
      if (b == 3) {
        s += ",";
        b = 0;
      }
      s += sum[i];
      b++;
    }
    return s.split("").reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 1,
                  color: dateTime.year == 2023 && dateTime.month == 1
                      ? Colors.grey
                      : Colors.blue),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                lastMonth();
              },
              icon: Icon(
                Icons.arrow_left,
                size: 30,
                color: dateTime.year == 2023 && dateTime.month == 1
                    ? Colors.grey
                    : Colors.blue,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                moneyFormat(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              Text(
                "so'm",
                style: TextStyle(fontWeight: FontWeight.bold, height: 0.3),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 1,
                  color: dateTime.year == 2024 && dateTime.month == 12
                      ? Colors.grey
                      : Colors.blue),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                nextMonth();
              },
              icon: Icon(
                Icons.arrow_right,
                size: 30,
                color: dateTime.year == 2024 && dateTime.month == 12
                    ? Colors.grey
                    : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

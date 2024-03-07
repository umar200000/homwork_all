import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthController extends StatelessWidget {
  final void Function(BuildContext context) pickMonth;
  final DateTime dateTime;
  const MonthController(this.dateTime, this.pickMonth, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          pickMonth(context);
        },
        child: Text(
          DateFormat("MMMM, y").format(dateTime),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ));
  }
}

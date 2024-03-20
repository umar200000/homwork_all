import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

// class NumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final formatter = NumberFormat('#,###', 'ru-RU');
//     return TextEditingValue(text: formatter.format(int.parse(newValue.text)));
//   }
// }

class BottomSheet1 extends StatefulWidget {
  final void Function(String title, DateTime time, String sum) addNewExpense;
  const BottomSheet1(this.addNewExpense, {super.key});

  @override
  State<BottomSheet1> createState() => _BottomSheet1State();
}

class _BottomSheet1State extends State<BottomSheet1> {
  DateTime? dateTime;
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  int a = 0;
  int b = 0;
  int c = 0;
  bool t = false;
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]);

    if (icon != null) {
      _icon = Icon(
        icon,
        size: 30,
        color: Colors.black,
      );
    }
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  void chooseDay(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDate: dateTime ?? DateTime.now(),
      helpText: "XARAJAT KUNINI TANLASH",
      cancelText: "BEKOR QILISH",
      confirmText: "TANLASH",
    ).then((value) {
      if (value != null) {
        setState(() {
          dateTime = value;
          c = 0;
        });
      }
    });
  }

  void checkInformation() {
    text1.text.isEmpty ? a = 1 : a = 0;
    text2.text.isEmpty ? b = 1 : b = 0;
    dateTime == null ? c = 1 : c = 0;
  }

  String moneyFormat(String str) {
    str = str.replaceAll(RegExp(r'[^0-9]'), '');
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

  Timer? timer;

  void snackBar() {
    setState(() {
      t = true;
    });

    timer = Timer(const Duration(milliseconds: 3500), () {
      setState(() {
        t = false;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom
                : 100),
        child: Column(
          children: [
            TextField(
              controller: text1,
              onChanged: (text) {
                setState(() {
                  if (text.isNotEmpty) {
                    a = 0;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Xarajat nomi",
                labelStyle: TextStyle(color: a == 0 ? Colors.grey : Colors.red),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: a == 0 ? Colors.grey : Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: a == 0 ? Colors.grey : Colors.red)),
              ),
            ),
            TextField(
              controller: text2,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  text2.text = moneyFormat(text);

                  if (text2.text.isNotEmpty) {
                    b = 0;
                  }
                });
              },
              // inputFormatters: [
              //   FilteringTextInputFormatter.digitsOnly,
              //   NumberFormatter(),
              // ],
              decoration: InputDecoration(
                labelText: "Xarajat miqdori",
                labelStyle: TextStyle(color: b == 0 ? Colors.grey : Colors.red),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: b == 0 ? Colors.grey : Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: b == 0 ? Colors.grey : Colors.red)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateTime == null
                      ? "Xarajat kuni tanlanmadi!"
                      : "Xarajat kuni: ${DateFormat("MMMM d, y").format(dateTime!)}",
                  style: TextStyle(
                      fontSize: 13, color: c == 0 ? Colors.black : Colors.red),
                ),
                TextButton(
                  onPressed: () {
                    chooseDay(context);
                  },
                  child: const Text("KUNNI TANLASH"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _icon == null ? const Text("Icon tanlanmadi!") : _icon!,
                TextButton(
                  onPressed: () {
                    _pickIcon();
                  },
                  child: const Text("ICON TANLASH"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("BEKOR QILISH"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String s = text1.text;
                    if (text1.text.isEmpty ||
                        dateTime == null ||
                        text2.text.isEmpty) {
                      Vibration.vibrate();
                      setState(() {
                        checkInformation();
                      });
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Yuqoridilani barchasini toldiring"),
                      //   duration: Duration(seconds: 4),
                      // ));
                      if (!t) snackBar();

                      return;
                    }
                    if (s.replaceAll(" ", "").isEmpty) {
                      Vibration.vibrate();
                      setState(() {
                        a = 1;
                      });
                      if (!t) snackBar();
                      return;
                    }

                    if (int.parse(text2.text.replaceAll(" ", "")) < 0) {
                      setState(() {
                        b = 1;
                      });
                      if (!t) snackBar();
                      return;
                    }

                    widget.addNewExpense(
                        text1.text, dateTime!, text2.text.replaceAll(" ", ","));
                    Navigator.pop(context);
                  },
                  child: const Text("KIRITISH"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            t
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Yuqoridilani barchasini toldiring!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 40,
                  ),
          ],
        ),
      ),
    );
  }
}

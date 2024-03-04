import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 238, 251, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(55)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Salary budget: "),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 15,
                ),
                label: Text(
                  "10.000.000 so'm",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              Expanded(
                  child: Container(
                height: 1,
              )),
              Text("48.9%"),
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
              widthFactor: 0.48,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue, spreadRadius: -2, blurRadius: 15)
                    ],
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      Colors.blue,
                      Colors.blue.shade100,
                      Colors.blue,
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}

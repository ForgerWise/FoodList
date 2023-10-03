import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodlist/page/add_page.dart';

class ListRifTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String inputdate;
  final String expdate;
  Function(BuildContext)? deleteFunction;
  ListRifTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.inputdate,
      required this.expdate,
      this.deleteFunction});

  String getDate() {
    var now = DateTime.now().toString();
    var dateParse = DateTime.parse(now);
    var dateShow = "${dateParse.year}/${dateParse.month}/${dateParse.day}";
    return dateShow;
  }

  int getState(String expdate) {
    var now = DateTime.now().toString();
    var dateParse = DateTime.parse(now);
    var dateShow = "${dateParse.year}/${dateParse.month}/${dateParse.day}";
    var date = dateShow.split("/");
    var year = int.parse(date[0]);
    var month = int.parse(date[1]);
    var day = int.parse(date[2]);
    var nowDate = DateTime(year, month, day);
    var expDate = expdate.split("/");
    var expYear = int.parse(expDate[0]);
    var expMonth = int.parse(expDate[1]);
    var expDay = int.parse(expDate[2]);
    var exp = DateTime(expYear, expMonth, expDay);
    var diff = exp.difference(nowDate).inDays;
    if (diff > 0) {
      return 1;
    } else if (diff == 0) {
      return 0;
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                Navigator.pushNamed(context, '/add',
                    arguments: AddPage(title, subtitle, inputdate, expdate));
              },
              icon: Icons.edit_outlined,
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              spacing: 2,
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_outline,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(10),
              spacing: 2,
            ),
          ],
        ),
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          decoration: BoxDecoration(
            color: getState(expdate) == 1
                ? Colors.green
                : getState(expdate) == 0
                    ? Colors.yellow
                    : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Entry Date", style: TextStyle(fontSize: 10)),
                  Text(inputdate,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text("Expire Date", style: TextStyle(fontSize: 10)),
                  Text(expdate,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodlist/database/data.dart';
import '../generated/l10n.dart';
import '../page/add_page.dart';

class ListRifTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String inputdate;
  final String expdate;
  final Function(BuildContext)? deleteFunction;

  ListRifTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.inputdate,
    required this.expdate,
    this.deleteFunction,
  });

  @override
  _ListRifTileState createState() => _ListRifTileState();
}

class _ListRifTileState extends State<ListRifTile> {
  InputDataBase IDB = InputDataBase();

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
                    arguments: AddPageArguments(
                      category: widget.title,
                      subcategory: widget.subtitle,
                      inputdate: widget.inputdate,
                      expdate: widget.expdate,
                    ));
              },
              icon: Icons.edit_outlined,
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              spacing: 2,
            ),
            SlidableAction(
              onPressed: widget.deleteFunction,
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
            color: getState(widget.expdate) == 1
                ? Colors.green
                : getState(widget.expdate) == 0
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
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).entryDate,
                      style: const TextStyle(fontSize: 10)),
                  Text(
                    widget.inputdate,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(S.of(context).expireDate,
                      style: const TextStyle(fontSize: 10)),
                  Text(
                    widget.expdate,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
}

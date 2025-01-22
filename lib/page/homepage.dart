import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../database/data.dart';
import '../generated/l10n.dart';
import 'add_page.dart';
import '../util/list_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  bool _showadd = true;
  InputDataBase IDB = InputDataBase();

  @override
  void initState() {
    if (_myBox.get("INGREDIENTS_LIST") == null) {
      // first time to open app
      IDB.createInitialData();
      IDB.updateData();
    } else {
      // not first time to open app
      IDB.loadData();
    }

    super.initState();
  }

  deleteTask(int index) {
    setState(() {
      IDB.ingredientsList.removeAt(index);
    });
    IDB.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final ScrollDirection direction = notification.direction;
        setState(() {
          if (direction == ScrollDirection.reverse) {
            _showadd = false;
          } else if (direction == ScrollDirection.forward) {
            _showadd = true;
          }
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text(S.of(context).foodlist,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          centerTitle: true,
        ),
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: IDB.ingredientsList.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ListRifTile(
                      title: IDB.ingredientsList[index][0],
                      subtitle: IDB.ingredientsList[index][1],
                      inputdate: IDB.ingredientsList[index][2],
                      expdate: IDB.ingredientsList[index][3],
                      deleteFunction: (context) => deleteTask(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: _showadd
            ? FloatingActionButton.extended(
                backgroundColor: Colors.blueGrey,
                onPressed: () async {
                  await Navigator.pushNamed(context, '/add',
                          arguments: const AddPage())
                      .then((_) {
                    setState(() {
                      IDB.loadData();
                    });
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(S.of(context).add,
                    style: const TextStyle(color: Colors.white)),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

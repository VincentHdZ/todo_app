import 'package:flutter/material.dart';

import '../storage/databaseHelper.dart';

class TodoCounter extends StatefulWidget {
  final DatabaseHelper db;

  TodoCounter(this.db);

  @override
  _TodoCounterState createState() => _TodoCounterState();
}

class _TodoCounterState extends State<TodoCounter> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.db.getCountTodos(),
      builder: (BuildContext buildContext, AsyncSnapshot<int> snapShot) {
        return Text(
          'Todo de UserName : ${snapShot.data.toString()}',
        );
      },
    );
  }
}

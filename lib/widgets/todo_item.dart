import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final Function deleteHandler;
  final Function editHandler;

  TodoItem(this.todo, this.deleteHandler, this.editHandler);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: const Icon(
                Icons.check,
                size: 35,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      key: ValueKey(widget.todo.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.todo.isChecked = true;
          widget.deleteHandler(widget.todo.id, context);
        }
      },
      direction: DismissDirection.startToEnd,
      resizeDuration: Duration(
        milliseconds: 570,
      ),
      movementDuration: Duration(milliseconds: 1500),
      child: Container(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Radio(
                value: true,
                groupValue: widget.todo.isChecked,
                onChanged: (valueRadio) {
                  setState(() {
                    widget.todo.isChecked = valueRadio;
                    widget.deleteHandler(widget.todo.id, context);
                  });
                },
              ),
              title: Text(
                widget.todo.title,
                style: widget.todo.isChecked
                    ? TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                      )
                    : TextStyle(fontSize: 20),
              ),
              onTap: () => widget.editHandler(context, widget.todo),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 10,
              endIndent: 0,
            ),
          ],
        ),
      ),
    );
  }
}

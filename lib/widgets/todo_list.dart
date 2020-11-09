import 'package:flutter/material.dart';

import '../storage/databaseHelper.dart';

import '../models/todo.dart';

import './todo_item.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  final Function deleteHandler;
  final Function editHandler;

  TodoList(this.todos, this.deleteHandler, this.editHandler);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DatabaseHelper db = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.todos.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoItem(widget.todos[index], widget.deleteHandler, widget.editHandler);
        },
      ),
    );
  }
}

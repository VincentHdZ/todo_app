import 'package:flutter/material.dart';

import '../models/todo.dart';

import '../widgets/journey_start.dart';
import '../widgets/todo_counter.dart';
import '../widgets/todo_list.dart';

import '../storage/databaseHelper.dart';

import '../resources/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = new TextEditingController();
  final DatabaseHelper db = new DatabaseHelper();
  List<Todo> todos = new List<Todo>();

  void _startAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: _textController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: Strings.createNewTodo,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          child: Text(
                            Strings.saveNewTodo,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            if (_textController.text.isEmpty) {
                              return;
                            }
                            setState(() {
                              db.saveTodo(
                                new Todo(
                                  title: _textController.text,
                                  isChecked: false,
                                ),
                              );
                              _textController.text = "";
                              Navigator.of(context).pop();
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteHandler(int id, BuildContext ctx) {
    setState(() {
      db.deleteTodo(id);
      todos.removeWhere((element) => element.id == id);
    });
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      content: Text(
        Strings.todoChecked,
        style: TextStyle(
          fontSize: 20,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        ),
        textAlign: TextAlign.center,
      ),
    );
    Scaffold.of(ctx).showSnackBar(snackBar);
  }

  void _editHandler(BuildContext ctx, Todo _todo) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: false,
                controller: _textController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: _todo.title,
                  fillColor: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        Strings.saveNewTodo,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_textController.text.isEmpty) {
                            return;
                          }
                          db.updateTodo(Todo(
                            id: _todo.id,
                            title: _textController.text,
                            isChecked: _todo.isChecked,
                          ));
                          _textController.text = "";
                          Navigator.of(context).pop();
                        });
                        final snackBar = SnackBar(
                          content: Text(
                            Strings.todoUpdated,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                        Scaffold.of(ctx).showSnackBar(snackBar);
                      }),
                ],
              )
            ],
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TodoCounter(db),
      ),
      body: FutureBuilder(
        future: db.getAllTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            todos = snapshot.data;
            if (todos.length > 0) {
              return TodoList(todos, _deleteHandler, _editHandler);
            }
          }
          return JourneyStart();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          _startAddNewTodo(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

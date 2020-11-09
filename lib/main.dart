import 'package:flutter/material.dart';

import './screens/home_screen.dart';

Future main() async => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
          ),
          iconTheme: new IconThemeData(
            opacity: 1,
            size: 30,
          ),
          fontFamily: 'Opensans',
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            textTheme: TextTheme(
              headline5: TextStyle(),
            ),
          ),
          bottomAppBarColor: Color.fromRGBO(0, 0, 0, 0.6),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
          )),
      home: HomeScreen(),
    );
  }
}

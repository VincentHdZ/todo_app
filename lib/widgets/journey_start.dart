import 'package:flutter/material.dart';

import '../resources/strings.dart';

class JourneyStart extends StatelessWidget {
  final _urlAssetImage = "assets/images/journey_finished.png";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Image.asset(
                _urlAssetImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              Strings.newStart,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                Strings.newTodoRequest,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

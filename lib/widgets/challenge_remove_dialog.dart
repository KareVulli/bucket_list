import 'package:bucketlist/models/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeRemoveDialog extends StatelessWidget {
  final Challenge _challenge;
  ChallengeRemoveDialog(this._challenge);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Mark "${_challenge.name}" as done?'),
      actions: <Widget>[
        new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(false)
        ),
        new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              //_removeTodoItem(index);
              Navigator.of(context).pop(true);
            }
        )
      ]
    );
  }

}
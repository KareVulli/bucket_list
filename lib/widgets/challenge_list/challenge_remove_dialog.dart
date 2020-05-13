import 'package:bucketlist/models/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeRemoveDialog extends StatelessWidget {
  final Challenge _challenge;
  ChallengeRemoveDialog(this._challenge);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    return  AlertDialog(
      title: Text('Delete challenge "${_challenge.name}"?'),
      actions: <Widget>[
        FlatButton(
          child: Text('NO'),
          onPressed: () => Navigator.of(context).pop(false)
        ),
        FlatButton(
          child: Text('YES'),
          onPressed: () {
            Navigator.of(context).pop(true);
          }
        )
      ]
    );
  }

}
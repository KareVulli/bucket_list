import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge_event.dart';
import 'package:bucketlist/widgets/challenge_remove_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/challenge.dart';


class ChallengeDetails extends StatelessWidget {
  final Challenge _challenge;

  ChallengeDetails(this._challenge);

  _removeChallenge(BuildContext context) async {
    bool result = await showDialog(
      context: context,
        builder: (context) {
          return ChallengeRemoveDialog(_challenge);
        }
    );
    if (result == true) {
      final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
      challengeBloc.add(RemoveChallengeEvent(_challenge));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(_challenge.name),
      contentPadding: EdgeInsets.all(24),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(_challenge.dateTime.toIso8601String()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(_challenge.description),
        ),
        RaisedButton(
          onPressed: () => _removeChallenge(context),
          child: Text('Remove Challenge'),
        )
      ],
    );
  }
}
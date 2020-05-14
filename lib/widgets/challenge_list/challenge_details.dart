import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:bucketlist/bloc/challenge/challenge_state.dart';
import 'package:bucketlist/screens/add_challenge.dart';
import 'package:bucketlist/widgets/challenge_list/challenge_remove_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/challenge.dart';


class ChallengeDetails extends StatelessWidget {
  final String _challengeId;

  ChallengeDetails(this._challengeId);

  _toggleDone(BuildContext context) async {
    // ignore: close_sinks
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    challengeBloc.add(ToggleChallengeDoneEvent(_challengeId));
  }

  _editChallenge(BuildContext context, Challenge challenge) async {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<ChallengeBloc>(context),
                child: AddChallenge(challenge)
            )
        )
    );
  }

  _removeChallenge(BuildContext context, Challenge challenge) async {
    bool result = await showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
          value: BlocProvider.of<ChallengeBloc>(context),
          child: ChallengeRemoveDialog(challenge)
      )
    );
    if (result == true) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final challengesBloc = BlocProvider.of<ChallengeBloc>(context);
    return BlocBuilder(
      bloc: challengesBloc,
      builder: (BuildContext context, ChallengeState state) {
        final challenge = state.challengeList.firstWhere((c) => c.uid == _challengeId, orElse: () => Challenge());
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(challenge.name),
              InkWell(
                onTap: () => _editChallenge(context, challenge),
                child: Icon(
                  Icons.create,
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Icon(Icons.event),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                      DateFormat('dd.MM.yyyy - kk:mm').format(challenge.dateTime),
                      style: Theme.of(context).textTheme.body2
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(challenge.description),
            ),
            _buildDoneCheckMark(context, challenge),
            _buildToggleButton(context, challenge),
            RaisedButton(
              onPressed: () => _removeChallenge(context, challenge),
              child: Text('Remove Challenge'),
            ),
          ],
        );
      }
    );
  }

  _buildDoneCheckMark(BuildContext context, Challenge challenge) {
    if (challenge.done) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
                Icons.check_circle,
                color: Colors.green
            ),
          ),
          Text(
            'Completed',
            style: Theme.of(context).textTheme.body2
          )
        ],
      );
    } else {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
                Icons.check_circle_outline,
                color: Colors.grey
            ),
          ),
          Text(
            'Not completed',
            style: Theme.of(context).textTheme.body2
          )
        ],
      );
    }
  }

  _buildToggleButton(BuildContext context, Challenge challenge) {
    if (challenge.done) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          onPressed: () => _toggleDone(context),
          child: Text('Mark as not completed'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          onPressed: () => _toggleDone(context),
          colorBrightness: Brightness.dark,
          color: Theme.of(context).primaryColor,
          child: Text('Mark as completed'),
        ),
      );
    }
  }
}
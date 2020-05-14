import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:bucketlist/widgets/challenge_list/challenge_details.dart';
import 'package:bucketlist/widgets/challenge_list/challenge_remove_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/challenge.dart';


class ChallengeItem extends StatelessWidget {
  final Challenge _challenge;

  ChallengeItem(this._challenge);

  void _openDetailsDialog(context) async {
    bool result = await showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ChallengeBloc>(context),
        child: ChallengeDetails(_challenge.uid)
      )
    );
    if (result == true) {
      // ignore: close_sinks
      final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
      challengeBloc.add(RemoveChallengeEvent(_challenge.uid));
    }
  }

  _openRemoveDialog(BuildContext context) async {
    bool result = await showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
          value: BlocProvider.of<ChallengeBloc>(context),
          child: ChallengeRemoveDialog(_challenge)
      )
    );
    if (result == true) {
      // ignore: close_sinks
      final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
      challengeBloc.add(RemoveChallengeEvent(_challenge.uid));
    }
  }

  _toggleDone(BuildContext context) async {
    // ignore: close_sinks
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    challengeBloc.add(ToggleChallengeDoneEvent(_challenge.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _openDetailsDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () => _toggleDone(context),
                      child: _buildDoneCheckMark(),
                    ),
                  ),
                  Text(
                    _challenge.name,
                    style: Theme.of(context).textTheme.title
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('dd.MM.yyyy - kk:mm').format(_challenge.dateTime),
                      style: Theme.of(context).textTheme.body2
                    ),
                    InkWell(
                      onTap: () => _openRemoveDialog(context),
                      child: Icon(
                          Icons.delete_outline,
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDoneCheckMark() {
    if (_challenge.done) {
      return Icon(
        Icons.check_circle,
        color: Colors.green
      );
    } else {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.grey
      );
    }
  }
}
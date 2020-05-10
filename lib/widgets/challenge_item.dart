import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/widgets/challenge_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/challenge.dart';


class ChallengeItem extends StatelessWidget {
  final Challenge _challenge;

  ChallengeItem(this._challenge);

  void _openDetailsDialog(context) {
    showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<ChallengeBloc>(context),
          child: ChallengeDetails(_challenge)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetailsDialog(context),
      child: ListTile(
          title: new Text(_challenge.name)
      ),
    );
  }
}
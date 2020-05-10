

import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/screens/add_challenge.dart';
import 'package:bucketlist/widgets/challenge_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeListScreen extends StatelessWidget {
  void _pushAddTodoScreen(context) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<ChallengeBloc>(context),
                child: AddChallenge()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Todo List')
      ),
      body: ChallengeList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _pushAddTodoScreen(context), // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: Icon(Icons.add)
      ),
    );
  }
}
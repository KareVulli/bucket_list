import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/screens/challenge_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: BlocProvider(
        create: (BuildContext context) => ChallengeBloc(),
        child: ChallengeListScreen(),
      )
    );
  }
}
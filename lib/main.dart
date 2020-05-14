import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/logger_bloc_delegate.dart';
import 'package:bucketlist/bloc/user/user_actions.dart';
import 'package:bucketlist/bloc/user/user_bloc.dart';
import 'package:bucketlist/screens/wrapper.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = LoggerBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  final Auth _auth = Auth();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bucket List',
      home: BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(_auth)..add(AppStarted()),
        child: WrapperScreen(),
      ),
    );
  }
}
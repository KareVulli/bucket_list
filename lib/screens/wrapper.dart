import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/user/user_bloc.dart';
import 'package:bucketlist/bloc/user/user_state.dart';
import 'package:bucketlist/screens/challenge_list.dart';
import 'package:bucketlist/screens/welcome.dart';
import 'package:bucketlist/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is UserAuthenticated) {
          final Database databaseService = Database(state.user.id);
          return BlocProvider<ChallengeBloc>(
            create: (BuildContext context) => ChallengeBloc(databaseService)..add(LoadChallengesEvent()),
            child: ChallengeListScreen()
          );
        } else if (state is UserUnauthenticated) {
          return Welcome();
        }
        return Scaffold();
      },
    );
  }
}

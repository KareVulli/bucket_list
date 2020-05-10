import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge_state.dart';
import 'package:bucketlist/models/challenge.dart';
import 'package:bucketlist/widgets/challenge_item.dart' as Item;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeList extends StatelessWidget {
  ChallengeList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeBloc, ChallengeState>(
      builder: (context, state) {
        return _buildList(context, state.challengeList);
      },
    );
  }

  ListView _buildList(context, List<Challenge> challengeList) {
    return ListView.builder(
      itemCount: challengeList.length,
      itemBuilder: (context, int) {
        return Item.ChallengeItem(challengeList[int]);
      },
    );
  }

}

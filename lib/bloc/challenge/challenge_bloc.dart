import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:bucketlist/bloc/challenge/challenge_state.dart';
import 'package:bucketlist/services/database.dart';

class ChallengeBloc extends Bloc<ChallengeAction, ChallengeState> {
  final Database _databaseService;
  StreamSubscription _challengesSubscription;

  ChallengeBloc(this._databaseService);

  @override
  ChallengeState get initialState => ChallengeState();

  @override
  Stream<ChallengeState> mapEventToState(ChallengeAction event) async* {
    if (event is LoadChallengesEvent) {
      _challengesSubscription?.cancel();
      _challengesSubscription = _databaseService.challenges().listen(
          (challenges) => add(ChallengesUpdated(challenges))
      );
    }  else if (event is AddChallengeEvent) {
      _databaseService.createOrUpdateChallenge(event.challenge);
    } else if (event is RemoveChallengeEvent) {
      _databaseService.deleteChallenge(event.challengeId);
    } else if (event is ToggleChallengeDoneEvent) {
      final challenge = state.challengeList.firstWhere((c) => c.uid == event.challengeId);
      challenge.done = !challenge.done;
      _databaseService.createOrUpdateChallenge(challenge);
    } else if (event is ChallengesUpdated) {
      yield ChallengeState(event.challenges);
    }
  }

}
import 'package:bloc/bloc.dart';
import 'package:bucketlist/bloc/challenge_event.dart';
import 'package:bucketlist/bloc/challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  @override
  ChallengeState get initialState => ChallengeState();

  @override
  Stream<ChallengeState> mapEventToState(ChallengeEvent event) async* {
    if (event is AddChallengeEvent) {
      yield ChallengeState(state.challengeList..add(event.challenge));
    } else if (event is RemoveChallengeEvent) {
      yield ChallengeState(state.challengeList.where((c) => c.id != event.challengeId).toList());
    } else if (event is ToggleChallengeDoneEvent) {
      final challenge = state.challengeList.firstWhere((c) => c.id == event.challengeId);
      challenge.done = !challenge.done;
      yield ChallengeState(state.challengeList);
    }
  }

}
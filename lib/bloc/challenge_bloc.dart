import 'package:bloc/bloc.dart';
import 'package:bucketlist/bloc/challenge_event.dart';
import 'package:bucketlist/bloc/challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  @override
  ChallengeState get initialState => ChallengeState.initial();

  @override
  Stream<ChallengeState> mapEventToState(ChallengeEvent event) async* {
    if (event is AddChallengeEvent) {
      yield state..challengeList.add(event.challenge);
    } else if (event is RemoveChallengeEvent) {
      yield state..challengeList.remove(event.challenge);
    }
  }

}
import 'package:bucketlist/models/challenge.dart';

class ChallengeState {
  List<Challenge> challengeList;

  ChallengeState._();

  factory ChallengeState.initial() {
    return ChallengeState._()..challengeList = List<Challenge>();
  }
}
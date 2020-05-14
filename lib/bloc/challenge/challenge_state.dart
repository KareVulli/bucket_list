import 'package:bucketlist/models/challenge.dart';

class ChallengeState {
  List<Challenge> challengeList;

  ChallengeState([challengeList])
      : this.challengeList = challengeList == null ? List<Challenge>() : challengeList;
}
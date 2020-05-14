import 'package:bucketlist/models/challenge.dart';

abstract class ChallengeAction {}

class LoadChallengesEvent extends ChallengeAction {
  LoadChallengesEvent();
}

class ChallengesUpdated extends ChallengeAction {
  final List<Challenge> challenges;

  ChallengesUpdated(this.challenges);
}

class AddChallengeEvent extends ChallengeAction {
  final Challenge challenge;

  AddChallengeEvent(this.challenge);
}

class RemoveChallengeEvent extends ChallengeAction {
  final String challengeId;

  RemoveChallengeEvent(this.challengeId);
}

class ToggleChallengeDoneEvent extends ChallengeAction {
  final String challengeId;

  ToggleChallengeDoneEvent(this.challengeId);
}
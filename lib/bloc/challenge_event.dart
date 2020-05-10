import 'package:bucketlist/models/challenge.dart';

abstract class ChallengeEvent {}

class AddChallengeEvent extends ChallengeEvent {
  final Challenge challenge;

  AddChallengeEvent(this.challenge);
}

class RemoveChallengeEvent extends ChallengeEvent {
  final Challenge challenge;

  RemoveChallengeEvent(this.challenge);
}
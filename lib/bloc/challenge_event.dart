import 'package:bucketlist/models/challenge.dart';
import 'package:flutter/material.dart';

abstract class ChallengeEvent {}

class AddChallengeEvent extends ChallengeEvent {
  final Challenge challenge;

  AddChallengeEvent(this.challenge);
}

class RemoveChallengeEvent extends ChallengeEvent {
  final UniqueKey challengeId;

  RemoveChallengeEvent(this.challengeId);
}

class ToggleChallengeDoneEvent extends ChallengeEvent {
  final UniqueKey challengeId;

  ToggleChallengeDoneEvent(this.challengeId);
}
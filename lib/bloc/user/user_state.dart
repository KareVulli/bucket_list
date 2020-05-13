import 'package:bucketlist/models/user.dart';

abstract class UserState {}

class UserUninitialized extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated(this.user);
}

class UserUnauthenticated extends UserState {}

class UserLoading extends UserState {}
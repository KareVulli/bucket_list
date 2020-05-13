import 'package:bucketlist/bloc/user/user_actions.dart';
import 'package:bucketlist/bloc/user/user_state.dart';
import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserAction, UserState> {
  final Auth _auth;

  UserBloc(this._auth);

  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserAction event) async* {
    if (event is LogInWithGoogle) {
      User user = await _auth.handleGoogleSignIn();
      if (user != null) {
        yield UserAuthenticated(user);
      }
    } else if (event is AppStarted) {
      if (await _auth.isSignedIn()) {
        yield UserAuthenticated(await _auth.getUser());
      } else {
        yield UserUnauthenticated();
      }
    } else if (event is LogOut) {
      await _auth.handleSignOut();
      yield UserUnauthenticated();
    }
  }
}

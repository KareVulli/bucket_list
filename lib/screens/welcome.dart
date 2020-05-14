import 'package:bucketlist/bloc/user/user_actions.dart';
import 'package:bucketlist/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bucket List')
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Welcome to Bucket List",
                    style: Theme.of(context).textTheme.display1
                ),
              ),
            ),
            Center(
              child: SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () => _onLoginPressed(context),
              ),
            ),
          ],
        ),
      )
    );
  }

  void _onLoginPressed(context) async {
    // ignore: close_sinks
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(LogInWithGoogle());
  }
}
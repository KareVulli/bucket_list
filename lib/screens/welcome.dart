import 'package:bucketlist/bloc/user/user_actions.dart';
import 'package:bucketlist/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(51,65,91, 0.4),
      appBar: AppBar(
          title: Text('Bucket List'),
          backgroundColor: Color.fromRGBO(51,65,91, 0.4),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: Text(
                    "Welcome to Bucket List",
                    style: Theme.of(context).textTheme.display1.apply(color: Colors.black),
                  ),
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
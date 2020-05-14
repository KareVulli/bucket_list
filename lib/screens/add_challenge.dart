import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/challenge.dart';


typedef OnSaveCallback = Function(Challenge challenge);

class AddChallenge extends StatefulWidget {
  final Challenge challenge;

  AddChallenge([this.challenge]);

  @override
  AddChallengeState createState() => AddChallengeState();
}

class AddChallengeState extends State<AddChallenge> {
  DateTime _dateTime = new DateTime.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateTimeController = TextEditingController();

  bool get isEditing => widget.challenge != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      Challenge challenge = widget.challenge;
      _nameController.text = challenge.name;
      _descriptionController.text = challenge.description;
      _dateTimeController.text = challenge.dateTime.toString();
      _dateTime = challenge.dateTime;
    }
  }

  void _selectDate() async  {
    DateTime current = new DateTime.now();
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: current,
        lastDate: DateTime(2101)
    );
    if(picked != null) setState(() => _dateTime = picked);
    _dateTimeController.text = picked.toString();
  }

  void _saveChallenge() {
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    Challenge challenge = widget.challenge;
    challenge.name = _nameController.text;
    challenge.description = _descriptionController.text;
    challenge.dateTime = _dateTime;
    challengeBloc.add(AddChallengeEvent(challenge));
    Navigator.of(context).pop(challenge);
  }

  void _addChallenge() {
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    Challenge challenge = Challenge();
    challenge.name = _nameController.text;
    challenge.description = _descriptionController.text;
    challenge.dateTime = _dateTime;
    challengeBloc.add(AddChallengeEvent(challenge));
    Navigator.of(context).pop(challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isEditing ? Text('Edit challenge') : Text('New challenge')
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Challenge",
                  hintText: 'Title of the challenge',
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: 'Write a description',
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate();
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: _dateTimeController,
                    decoration: InputDecoration(labelText: 'Due')
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => _addChallenge(),
                color: Colors.blue,
                textColor: Colors.white,
                child: isEditing ? Text('Save challenge') : Text('Add Challenge'),
              )
            ]
          )
        )
      )
    );
  }
}
import 'package:bucketlist/bloc/challenge/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge/challenge_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../models/challenge.dart';


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
      _dateTimeController.text = DateFormat('dd.MM.yyyy - kk:mm').format(challenge.dateTime);
      _dateTime = challenge.dateTime;
    }
  }

  void _selectDate() async  {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
    );
    if (picked == null) {
      return;
    }
    TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateTime)
    );
    if(picked != null && pickedTime != null) {
      DateTime newDateTime = _setTime(picked, pickedTime);
      setState(() => _dateTime = newDateTime);
      _dateTimeController.text = DateFormat('dd.MM.yyyy - kk:mm').format(newDateTime);
    }
  }

  DateTime _setTime(DateTime dateTime, TimeOfDay timeOfDay){
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute
    );
  }

  void _addChallenge() {
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    Challenge challenge = isEditing ? widget.challenge : Challenge();
    challenge.name = _nameController.text;
    challenge.description = _descriptionController.text;
    challenge.dateTime = _dateTime;
    challengeBloc.add(AddChallengeEvent(challenge));
    Navigator.of(context).pop(challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(51,65,91, 0.4),
      appBar: AppBar(
          title: isEditing ? Text('Edit challenge') : Text('New challenge'),
          backgroundColor: Color.fromRGBO(51,65,91, 0.4),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Challenge",
                  hintText: 'Title of the challenge',
                ),
              ),
              Container(height: 10), // set height
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Description",
                  hintText: 'Write a description',
                ),
              ),
              Container(height: 10), // set height
              InkWell(
                onTap: () {
                  _selectDate();
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: _dateTimeController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Due')
                  ),
                ),
              ),
              Container(height: 10), // set height
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
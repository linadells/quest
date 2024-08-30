import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/location.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class AddLocation extends StatefulWidget {
  AddLocation();

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final List<TextEditingController> _locationsControllers = [];

  @override
  void initState() {
    super.initState();
    _locationsControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _locationsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAnswerField() {
    if (_locationsControllers.length < 8) {
      setState(() {
        _locationsControllers.add(TextEditingController());
      });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('You cannot add more than 8 locations')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ..._locationsControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController answerController = entry.value;

                return Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  margin: EdgeInsets.all(3),
                  child: TextField(
                    controller: answerController,
                    decoration:
                        InputDecoration(labelText: 'Location ${index + 1}'),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                onPressed: _addAnswerField,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Add Location',
                    style: AppThemes.lightTheme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                onPressed: () {
                  final locations = _locationsControllers
                      .map((controller) => controller.text)
                      .where((text) => text.isNotEmpty)
                      .map((e) => LocationModel(location: e))
                      .toList();
                  if (locations.length == 0) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('You have to add at least one location')),
                    );
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddLocationEvent());
                  } else {
                    GoRouter.of(context).pop();
                    BlocProvider.of<CreateQuestBloc>(context).add(
                        FinishAddLocationEvent(locationModels: locations));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Submit',
                    style: AppThemes.lightTheme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

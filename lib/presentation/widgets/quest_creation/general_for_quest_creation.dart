import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class SettingsForQuest extends StatefulWidget {
  const SettingsForQuest({super.key});

  @override
  State<SettingsForQuest> createState() => _SettingsForQuestState();
}

class _SettingsForQuestState extends State<SettingsForQuest> {
  bool isShuffled = false;
  @override
  Widget build(BuildContext context) {
    int lenQuestions = BlocProvider.of<CreateQuestBloc>(context)
            .questModel
            .questions
            ?.length ??
        0;
    int lenLocations = BlocProvider.of<CreateQuestBloc>(context)
            .questModel
            .locations
            ?.length ??
        0;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shuffle locations'),
              Switch(
                  value: isShuffled,
                  onChanged: ((value) {
                    setState(() {
                      isShuffled = value;
                      BlocProvider.of<CreateQuestBloc>(context)
                          .questModel
                          .isShuffled = isShuffled;
                    });
                  }))
            ],
          ),
          Text('Quantity of question:$lenQuestions'),
          Text('Quantity of locations:$lenLocations'),
        ],
      ),
    );
  }
}

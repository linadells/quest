import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/widgets/quest_creation/add_location.dart';
import 'package:quest/presentation/widgets/quest_creation/add_question.dart';
import 'package:quest/presentation/widgets/quest_creation/general_for_quest_creation.dart';
import 'package:quest/presentation/widgets/quest_creation/list_of_locations.dart';
import 'package:quest/presentation/widgets/quest_creation/list_of_question.dart';
import 'package:quest/presentation/widgets/quest_creation/navigation_bar_create_quest.dart';

class CreateQuestPage extends StatelessWidget {
  late List<QuestionEntity> questions;
  late List<LocationEntity> locations;
  late QuestModel questModel;
  TextEditingController nameController = TextEditingController();

  CreateQuestPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: const NavigationBarCreateQuest(),
          body: BlocBuilder<CreateQuestBloc, CreateQuestState>(
            builder: (context, state) {
              questModel = BlocProvider.of<CreateQuestBloc>(context).questModel;
              questions = questModel.questions ?? [];
              locations = questModel.locations ?? [];
              if (state is AddingQuestionState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddQuestion();
                      });
                });
              } else if (state is AddingLocationState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddLocation();
                      });
                });
              } else if (state is LoadingQuestCreationState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Create your quest',
                        style: Theme.of(context).textTheme.displayLarge),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: 'Name of quest'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              questModel.name = nameController.text;
                              BlocProvider.of<CreateQuestBloc>(context).add(const FinishCreationQuestEvent());
                            },
                            child: Text('Create'))
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        ListOfQuestions(
                          questions: questions,
                        ),
                        ListOfLocations(
                          locations: locations,
                        ),
                        SettingsForQuest(),
                      ]),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

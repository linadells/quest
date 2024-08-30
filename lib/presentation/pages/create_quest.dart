import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/format_exception.dart';
import 'package:quest/data/models/location.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';
import 'package:quest/presentation/widgets/quest_creation/add_location.dart';
import 'package:quest/presentation/widgets/quest_creation/add_question.dart';
import 'package:quest/presentation/widgets/quest_creation/general_for_quest_creation.dart';
import 'package:quest/presentation/widgets/quest_creation/list_of_locations.dart';
import 'package:quest/presentation/widgets/quest_creation/list_of_question.dart';
import 'package:quest/presentation/widgets/quest_creation/navigation_bar_create_quest.dart';

class CreateQuestPage extends StatelessWidget {
  late List<QuestionModel> questions;
  late List<LocationModel> locations;
  late QuestModel questModel;
  TextEditingController nameController = TextEditingController();

  void setPropertiesToQuest(QuestModel quest, BuildContext context) {
    if (nameController.text.isNotEmpty)
      quest.name = nameController.text;
    else
      throw Exception('Name can`t be empty');
    quest.isShuffled = quest.isShuffled ?? false;
    int lenQuestions = questModel.questions?.length ?? 0;
    int lenLocations = questModel.locations?.length ?? 0;

    if (lenLocations != lenQuestions) {
      throw Exception(
          'Quantity of questions and locations have to be similar.');
    } else if (lenQuestions == 0) {
      throw Exception('Quantity of questions can`t be 0.');
    } else if (lenLocations == 0) {
      throw Exception('Quantity of locations can`t be 0.');
    } else {
      quest.quantityOfQuestions = lenQuestions;
      questModel.maxPoints = questModel.questions!
          .fold(0, (prevSum, question) => prevSum! + question.points);
    }
  }

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
                      }).then((_) {
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddQuestionEvent());
                  });
                });
              } else if (state is EditingQuestionState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddQuestion(questionModel: state.questionModel);
                      }).then((_) {
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddQuestionEvent());
                  });
                });
              }
              else if (state is AddingLocationState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddLocation();
                      }).then((_) {
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddLocationEvent());
                  });
                });
              } else if (state is LoadingQuestCreationState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FinishQuestCreationState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Your quest was created successfully'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                  GoRouter.of(context)
                                      .pushNamed(MyRoutes.mainScreen);
                                  BlocProvider.of<CreateQuestBloc>(context)
                                      .add(const LeaveQuestCreationEvent());
                                },
                                child: Text('Ok'))
                          ],
                        );
                      });
                });
              }
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Create your quest',
                        style: Theme.of(context).textTheme.displayLarge),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name of quest'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              try {
                                setPropertiesToQuest(questModel, context);
                                BlocProvider.of<CreateQuestBloc>(context)
                                    .add(const FinishCreationQuestEvent());
                              } on Exception catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(formatException(e))));
                              }
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

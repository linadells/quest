import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';

class QuestInList extends StatelessWidget {
  QuestModel questModel;
  QuestInList({super.key, required this.questModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CreateQuestBloc>(context).add(EditQuestEvent(questModel: questModel));
        GoRouter.of(context).pushNamed(MyRoutes.createQuestScreen);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: kStyleForQuestionContainer,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                questModel.name!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Container(
                decoration: kStyleForPoints,
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Points: ${questModel.maxPoints}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Column(
              children: questModel.questions!.map(
            (question) {
              return Row(
                children: [
                  Text(
                    '• ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Expanded(
                    child: Text(
                      question.question,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              );
            },
          ).toList()),
        ]),
      ),
    );
  }
}

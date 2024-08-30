
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class DisplayQuestion extends StatelessWidget {
  final QuestionModel questionModel;
  const DisplayQuestion({required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        BlocProvider.of<CreateQuestBloc>(context).add(EditQuestionEvent(questionModel));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: kStyleForQuestionContainer,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                questionModel.question,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Container(
                decoration: kStyleForPoints,
                padding: EdgeInsets.all(5),
                child: Text(
                  'Points: ${questionModel.points}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Column(
              children: questionModel.answers.map(
            (answer) {
              return Row(
                children: [
                  Text(
                    '• ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Expanded(
                    child: Text(
                      answer,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              );
            },
          ).toList()),
          Text(
            'Correct answer: ${questionModel.correctAnswer}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ]),
      ),
    );
  }
}

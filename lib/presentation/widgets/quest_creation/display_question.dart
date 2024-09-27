import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class DisplayQuestion extends StatelessWidget {
  QuestionModel questionModel;
  Function onDismiss;
  DisplayQuestion(
      {super.key, required this.questionModel, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CreateQuestBloc>(context)
            .add(EditQuestionEvent(questionModel));
      },
      child: Dismissible(
        key: Key(questionModel.question),
        onDismissed: (direction) {
          onDismiss();
        },
        background: Container(
          color: Colors.redAccent,
          child: Icon(Icons.delete),
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: kStyleForQuestionContainer,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  questionModel.question,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  decoration: kStyleForPoints,
                  padding: const EdgeInsets.all(5),
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
      ),
    );
  }
}

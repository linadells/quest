
import 'package:flutter/material.dart';
import 'package:quest/core/style.dart';
import 'package:quest/domain/entities/question.dart';

class DisplayQuestion extends StatelessWidget {
  final QuestionEntity questionEntity;
  const DisplayQuestion({required this.questionEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: kStyleForQuestionContainer,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              questionEntity.question,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Container(
              decoration: kStyleForPoints,
              padding: EdgeInsets.all(5),
              child: Text(
                'Points: ${questionEntity.points}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        Column(
            children: questionEntity.answers.map(
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
          'Correct answer: ${questionEntity.correctAnswer}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ]),
    );
  }
}

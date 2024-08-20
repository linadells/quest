import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/widgets/quest_creation/display_question.dart';

class ListOfQuestions extends StatelessWidget {
  List<QuestionEntity>? questions;
  ListOfQuestions({this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          Text(
            'Questions:',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Expanded(
            child: questions?.length!=0
                ? ListView.builder(
                    itemCount: questions != null ? questions!.length : 1,
                    itemBuilder: (context, index) =>
                        DisplayQuestion(questionEntity: questions![index]))
                : Center(child: Text('There aren`t any questions')),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<CreateQuestBloc>(context).add(AddQuestionEvent());
                  },
                  child: Text('Add questions'),
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return kAccent.withOpacity(0.6);
                        } else if (states.contains(MaterialState.hovered)) {
                          return kAccent.withOpacity(0.8);
                        }
                        return kAccent;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ]
    );
  }
}

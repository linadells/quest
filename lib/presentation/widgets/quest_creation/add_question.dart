import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class AddQuestion extends StatefulWidget {
  AddQuestion();

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final TextEditingController _controllerQuestion = TextEditingController();
  final List<TextEditingController> _answerControllers = [];
  int? _selectedAnswerIndex = 0;
  int points = 1;

  @override
  void initState() {
    super.initState();
    _answerControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _controllerQuestion.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAnswerField() {
    if (_answerControllers.length < 8) {
      setState(() {
        _answerControllers.add(TextEditingController());
      });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('You cannot add more than 8 answers')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: _controllerQuestion,
            decoration: InputDecoration(hintText: 'Your question'),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            margin: EdgeInsets.all(5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.zero), // Відсутність паддінгу
                  backgroundColor: MaterialStatePropertyAll(kMedium),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStatePropertyAll(
                    CircleBorder(), // Кругла форма кнопки
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (points != 1) points--;
                  });
                },
                child: Center(
                  child: Icon(
                    Icons.exposure_minus_1,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: kStyleForPoints,
            padding: EdgeInsets.all(5),
            child: Text(
              'Points: ${points}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  backgroundColor: MaterialStatePropertyAll(kMedium),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStatePropertyAll(
                    CircleBorder(),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (points != 10) points++;
                  });
                },
                child: Center(
                  child: Icon(
                    Icons.exposure_plus_1_outlined,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ]),
        Expanded(
          child: ListView(
            children: [
              ..._answerControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController answerController = entry.value;

                return Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: _selectedAnswerIndex,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedAnswerIndex = value;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.all(3),
                        child: TextField(
                          controller: answerController,
                          decoration:
                              InputDecoration(hintText: 'Answer ${index + 1}'),
                        ),
                      ),
                    ),
                  ],
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
                    'Add Answer',
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
                  final answers = _answerControllers
                      .map((controller) => controller.text)
                      .where((text) => text.isNotEmpty)
                      .toList();
                  if (answers.length == 0 || _controllerQuestion.text.isEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'You have to add question and at least one answear')),
                    );
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddQuestionEvent());
                  } else {
                    final question = QuestionModel(
                        id: 'id',
                        points: points,
                        question: _controllerQuestion.text,
                        answers: answers,
                        theme: 'theme',
                        correctAnswer: answers[_selectedAnswerIndex!]);
                    GoRouter.of(context).pop();
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddQuestionEvent(questionEntity: question));
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/format_exception.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class AddQuestion extends StatefulWidget {
  //QuestionModel? questionModel;
  //AddQuestion({this.questionModel});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final TextEditingController _controllerQuestion = TextEditingController();
  final List<TextEditingController> _answerControllers = [];
  int _selectedAnswerIndex = 0;
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
    try {
      if (_answerControllers.length < 8) {
        setState(() {
          _answerControllers.add(TextEditingController());
        });
      } else {
        throw Exception('You can`t add more than 8 answers');
      }
    } on Exception catch (e) {
      showExceptionAlert(e, context);
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
            decoration: InputDecoration(labelText: 'Your question'),
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
                          _selectedAnswerIndex = value!;
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
                              InputDecoration(labelText: 'Answer ${index + 1}'),
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
                  try {
                    if (_controllerQuestion.text.isEmpty) {
                      throw Exception('You have to add a question');
                    }
                    if (_answerControllers[_selectedAnswerIndex].text.isEmpty) {
                      throw Exception('Correct answer is empty');
                    }
                    String tempCorrectAnswer =
                        _answerControllers[_selectedAnswerIndex].text;
                    final answers = _answerControllers
                        .map((controller) => controller.text)
                        .where((text) => text.isNotEmpty)
                        .toList();
                    if (answers.length == 0) {
                      throw Exception('You have to add at least one answear');
                    }
                    final question = QuestionModel(
                        id: 'id',
                        points: points,
                        question: _controllerQuestion.text,
                        answers: answers,
                        theme: 'theme',
                        correctAnswer: tempCorrectAnswer);
                    GoRouter.of(context).pop();
                    BlocProvider.of<CreateQuestBloc>(context)
                        .add(FinishAddQuestionEvent(questionModel: question));
                  } on Exception catch (e) {
                    showExceptionAlert(e, context);
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

import 'package:quest/domain/entities/question.dart';

class AnswerEntity {
  QuestionEntity question;
  String answer;
  AnswerEntity({required this.answer, required this.question});
}

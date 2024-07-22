import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';

class AnswerEntity {
  QuestionEntity question;
  String answer;
  AnswerEntity({required this.answer, required this.question});
}

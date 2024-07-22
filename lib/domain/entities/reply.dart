import 'package:quest/domain/entities/question.dart';

class ReplyEntity{
  QuestionEntity question;
  int answer;

  ReplyEntity({required this.answer, required this.question});
}
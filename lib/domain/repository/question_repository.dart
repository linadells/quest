import 'package:quest/domain/entities/question.dart';

abstract class QuestionRepository{
  void createQuestion(QuestionEntity question);
}
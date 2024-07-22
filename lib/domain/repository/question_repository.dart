import 'package:quest/domain/entities/quest.dart';

abstract class QuestionRepository{
  bool getQuestion(QuestEntity, int idOfQuestion);
}
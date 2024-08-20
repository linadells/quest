import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';

abstract class QuestRepository {
  Future<void> createQuest(QuestEntity quest);
  void createQuestion(QuestEntity quest, QuestionEntity question);
}

import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';

abstract class QuestRepository {
  Future<String> createQuest(QuestModel quest);
  Future<List<QuestModel>> getMyQuests(String email);
  Future<void> editQuest(QuestModel quest);
}

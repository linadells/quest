import 'package:quest/core/data_state.dart';
import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';

abstract class QuestRepository {
  Future<DataState<List<QuestEntity>>> getQuests();
}

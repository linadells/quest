import 'package:quest/domain/entities/question.dart';

class QuestEntity {
  String id;
  int quantityOfQuestions;
  String name;
  int maxPoints;
  List<QuestionEntity> questions;

  QuestEntity(
      {required this.id,
      required this.quantityOfQuestions,
      required this.name,
      required this.maxPoints,
      required this.questions});
}

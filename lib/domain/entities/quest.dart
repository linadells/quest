import 'package:quest/domain/entities/question.dart';

class QuestEntity {
  String id;
  int quantityOfQuestions;
  String name;

  QuestEntity({required this.id, required this.quantityOfQuestions, required this.name});
}

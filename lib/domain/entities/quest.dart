
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';

class QuestEntity {
  String? id;
  int? quantityOfQuestions;
  String? name;
  int? maxPoints;
  List<QuestionEntity>? questions;
  List<LocationEntity>? locations;
  bool? isShuffled;

  QuestEntity();
}

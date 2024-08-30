
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';

class QuestEntity {
  String? id;
  int? quantityOfQuestions;
  String? name;
  int? maxPoints;
  covariant List<QuestionEntity>? questions;
  covariant List<LocationEntity>? locations;
  bool? isShuffled;

  QuestEntity();
}

import 'package:quest/data/models/location.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/quest.dart';

class QuestModel extends QuestEntity {
  QuestModel(
      {String? id,
      int? quantityOfQuestions,
      String? name,
      int? maxPoints,
      List<QuestionModel>? questions, 
      List<LocationModel>? locations, 
      bool? isShuffled})
      : super();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantityOfQuestions': quantityOfQuestions,
      'name': name,
      'maxPoints': maxPoints,
      'questions': questions,
    };
  }

  factory QuestModel.fromJson(Map<String, dynamic> json) {
    return QuestModel(
      id: json['id'],
      quantityOfQuestions: json['quantityOfQuestions'],
      name: json['name'],
      maxPoints: json['maxPoints'],
      questions: json['questions'],
      isShuffled: json['isShuffled'],
    );
  }
}

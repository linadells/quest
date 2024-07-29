import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/quest.dart';

class QuestModel extends QuestEntity {
  QuestModel(
      {required String id,
      required int quantityOfQuestions,
      required String name,
      required int maxPoints,
      required List<QuestionModel> questions})
      : super(
            id: id,
            quantityOfQuestions: quantityOfQuestions,
            name: name,
            maxPoints: maxPoints,
            questions: questions);

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
    );
  }
}

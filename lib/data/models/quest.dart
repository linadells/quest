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
      : super() {
    this.id = id;
    this.quantityOfQuestions = quantityOfQuestions;
    this.name = name;
    this.maxPoints = maxPoints;
    this.questions = questions;
    this.locations = locations;
    this.isShuffled = isShuffled;
  }

  @override
  List<LocationModel>? locations;
  @override
  List<QuestionModel>? questions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantityOfQuestions': quantityOfQuestions,
      'name': name,
      'maxPoints': maxPoints,
      'isShuffeled': isShuffled,
      'questions': questions != null
          ? questions?.map((question) => question.toJson()).toList()
          : null,
      'locations': locations != null
          ? locations?.map((locations) => locations.toJson()).toList()
          : null,
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

import 'package:quest/data/models/location.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/domain/entities/quest.dart';

class QuestModel extends QuestEntity {
  late String? id;
  QuestModel(
      {String? creatorEmail,
      int? quantityOfQuestions,
      String? name,
      int? maxPoints,
      List<QuestionModel>? questions,
      List<LocationModel>? locations,
      bool? isShuffled,
      String? id})
      : super() {
    this.id = id;
    this.creatorEmail = creatorEmail;
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
      'creatorEmail': creatorEmail,
      'quantityOfQuestions': quantityOfQuestions,
      'name': name,
      'maxPoints': maxPoints,
      'isShuffeled': isShuffled,
      'questions': questions?.map((question) => question.toJson()).toList(),
      'locations': locations?.map((locations) => locations.toJson()).toList(),
    };
  }

  factory QuestModel.fromJson(Map<String, dynamic> json, String id) {
    return QuestModel(
      id: id,
      creatorEmail: json['creatorEmail'],
      quantityOfQuestions: json['quantityOfQuestions'],
      name: json['name'],
      maxPoints: json['maxPoints'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList(),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((locationJson) => LocationModel.fromJson(locationJson))
          .toList(),
      isShuffled: json['isShuffled'],
    );
  }
}

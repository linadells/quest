import 'package:quest/domain/entities/question.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required String id,
    required int points,
    required String question,
    required List<String> answers,
    required String theme,
    required String correctAnswer,
  }) : super(
            id: id,
            points: points,
            question: question,
            answers: answers,
            theme: theme,
            correctAnswer: correctAnswer);

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points,
      'question': question,
      'answers': answers,
      'theme': theme,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      points: json['points'],
      question: json['question'],
      answers: List<String>.from(json['answers']),
      theme: json['theme'],
      correctAnswer: json['correctAnswer'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel &&
        other.id == id &&
        other.points == points &&
        other.question == question &&
        other.answers == answers &&
        other.theme == theme &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        points.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        theme.hashCode ^
        correctAnswer.hashCode;
  }
}

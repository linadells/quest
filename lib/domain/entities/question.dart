import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String id;
  final int points;
  final String question;
  final List<String> answers;
  final String theme;

  QuestionEntity(
      {required this.id,
      required this.points,
      required this.question,
      required this.answers,
      required this.theme});

  @override
  List<Object?> get props =>
      [id, points, question, answers, theme];
}

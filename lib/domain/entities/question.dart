import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String id;
  final int points;
  final String question;
  final List<String> answers;
  final String theme;
  final String correctAnswer;

  const QuestionEntity(
      {required this.id,
      required this.points,
      required this.question,
      required this.answers,
      required this.theme,
      required this.correctAnswer});

  @override
  List<Object?> get props => [id, points, question, answers, theme];
}

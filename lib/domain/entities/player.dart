import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/domain/entities/quest.dart';

class PlayerEntity {
  String email;
  String password;
  late UserCredential userCredential;
  int points;
  late QuestEntity quest;

  PlayerEntity({required this.email, this.points = 0, required this.password});
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/domain/entities/player.dart';
import 'package:quest/domain/entities/quest.dart';

class PlayerModel extends PlayerEntity {
  PlayerModel({
    required String email,
    required String password
  }) : super(email: email, password: password);
}

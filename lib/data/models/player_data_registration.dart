import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/domain/entities/player_data_registration.dart';

class PlayerModel extends PlayerDataRegistrationEntity {
  PlayerModel(
      {required String email,
      required String password,
      required String nickname})
      : super(email: email, password: password, nickname: nickname);
}

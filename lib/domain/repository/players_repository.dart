import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/core/data_state.dart';
import 'package:quest/domain/entities/player_data_registration.dart';

abstract class PlayersRepository {
  Future<DataState<UserCredential>> registerPlayer(PlayerDataRegistrationEntity player);
  Future<DataState<UserCredential>> logInPlayer(PlayerDataRegistrationEntity player);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/core/data_state.dart';
import 'package:quest/domain/entities/player_data_registration.dart';
import 'package:quest/domain/repository/players_repository.dart';
import 'package:quest/injection_container.dart';

class PlayersRepositoryImpl implements PlayersRepository {
  @override
  Future<DataState<UserCredential>> registerPlayer(
      PlayerDataRegistrationEntity player) async {
    final user = await sl<FirebaseAuth>().createUserWithEmailAndPassword(
        email: player.email.trim(), password: player.password.trim());
    await user.user?.updateDisplayName(player.nickname);
    await user.user?.reload();
    return DataSuccess<UserCredential>(user);
  }

  @override
  Future<DataState<UserCredential>> logInPlayer(
      PlayerDataRegistrationEntity player) async {
    return DataSuccess<UserCredential>(
        await sl<FirebaseAuth>().signInWithEmailAndPassword(
      email: player.email.trim(),
      password: player.password.trim(),
    ));
  }
}

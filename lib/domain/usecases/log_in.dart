import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/core/data_state.dart';
import 'package:quest/core/usecase.dart';
import 'package:quest/domain/entities/player_data_registration.dart';
import 'package:quest/domain/repository/players_repository.dart';

class LogInUseCase implements UseCase<DataState<UserCredential>, PlayerDataRegistrationEntity>{
  final PlayersRepository playersRepository;
  LogInUseCase(this.playersRepository);

  @override
  Future<DataState<UserCredential>> call({PlayerDataRegistrationEntity? params}) {
    return playersRepository.logInPlayer(params!);
  }
}
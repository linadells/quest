import 'package:quest/core/usecase.dart';
import 'package:quest/domain/entities/player.dart';
import 'package:quest/domain/repository/players_repository.dart';

class RegisterUseCase implements UseCase<void, PlayerEntity>{
  final PlayersRepository playersRepository;
  RegisterUseCase(this.playersRepository);

  @override
  Future<void> call({required PlayerEntity params}) {
    return playersRepository.registerPlayer(params.email, params.password);
  }
  
}
import 'package:quest/core/data_state.dart';
import 'package:quest/domain/entities/quest.dart';

abstract class PlayersRepository {
  Future<void> registerPlayer(String email, String password);
}

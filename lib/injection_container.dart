import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:quest/data/repository/players_repository.dart';
import 'package:quest/data/repository/quest_repository.dart';
import 'package:quest/domain/repository/players_repository.dart';
import 'package:quest/domain/usecases/log_in.dart';
import 'package:quest/domain/usecases/register.dart';
import 'package:quest/firebase_options.dart';

final sl=GetIt.instance;

Future<void> initializeDependencies() async {
  try {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<PlayersRepository>(PlayersRepositoryImpl());
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<LogInUseCase>(LogInUseCase(sl()));
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<QuestRepositoryImpl>(QuestRepositoryImpl());
  } catch (e) {
    print("Error during dependency registration: $e");
  }
}

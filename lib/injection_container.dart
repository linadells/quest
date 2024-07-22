import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:quest/firebase_options.dart';

final sl=GetIt.instance;

Future<void> initializeDependencies() async {
  try {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  } catch (e) {
    print("Error during dependency registration: $e");
    rethrow;
  }
}

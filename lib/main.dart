import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/usecases/log_in.dart';
import 'package:quest/domain/usecases/register.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/bloc/registration_bloc/bloc/registration_bloc.dart';
import 'package:quest/presentation/routes.dart/router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RegistrationBloc(RegisterUseCase(sl()), LogInUseCase(sl())),
        ),
        BlocProvider(
          create: (context) => CreateQuestBloc(QuestModel()),
        ),
      ],
      child: //WelcomeScreen(),
      MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRouter.returnRouter(false),
        theme: AppThemes.lightTheme,
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:quest/presentation/pages/create_quest.dart';
import 'package:quest/presentation/pages/main_page.dart';
import 'package:quest/presentation/pages/registration_page.dart';
import 'package:quest/presentation/pages/welcome_page.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';

class MyAppRouter {
  static GoRouter returnRouter(bool isAuth) {
    return GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          name: MyRoutes.welcomeScreen,
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            child: WelcomeScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: MyRoutes.loginScreen,
          path: '/login',
          pageBuilder: (context, state) => MaterialPage(
            child: RegistrationScreen(register: false),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: MyRoutes.registrationScreen,
          path: '/register',
          pageBuilder: (context, state) => MaterialPage(
            child: RegistrationScreen(
              register: true,
            ),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: MyRoutes.mainScreen,
          path: '/main',
          pageBuilder: (context, state) => MaterialPage(
            child: MainPage(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: MyRoutes.createQuestScreen,
          path: '/createQuest',
          pageBuilder: (context, state) => MaterialPage(
            child: CreateQuestPage(),
            key: state.pageKey,
          ),
        ),
      ],
    );
  }
}

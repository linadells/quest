import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/presentation/bloc/registration_bloc/bloc/registration_bloc.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose option to start',
                style: Theme.of(context).textTheme.displayLarge),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(MyRoutes.registrationScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Register',
                    style: AppThemes.lightTheme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(MyRoutes.loginScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Log in',
                    style: AppThemes.lightTheme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

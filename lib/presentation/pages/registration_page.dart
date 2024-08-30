import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/format_exception.dart';
import 'package:quest/core/style.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/registration_bloc/bloc/registration_bloc.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';

class RegistrationScreen extends StatelessWidget {
  final bool register;
  const RegistrationScreen({required this.register});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
        color: Colors.white,
      )),
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RegistrationError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(formatException(state.error))));
          } else if (state is RegistrationDone) {
            print('registered ${sl<FirebaseAuth>().currentUser}');

            GoRouter.of(context).pushNamed(MyRoutes.mainScreen);
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nicknameController = TextEditingController();
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start your quest',
                style: Theme.of(context).textTheme.displayLarge),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 20,
            ),
            register
                ? Column(
                    children: [
                      TextField(
                        controller: nicknameController,
                        decoration: InputDecoration(labelText: 'Nickname'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final String? nickname = nicknameController.text;
                  context.read<RegistrationBloc>().add(register
                      ? Register(
                          email: email, password: password, nickname: nickname!)
                      : LogIn(email: email, password: password));
                },
                child: Text(
                  register ? 'Register' : 'Log in',
                )),
          ],
        ),
      ),
    );
  }
}


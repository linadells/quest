import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Start your quest',
              style: Theme.of(context).textTheme.displayLarge),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 400, vertical: 10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          register
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 400, vertical: 10),
                  child: TextField(
                    controller: nicknameController,
                    decoration: InputDecoration(hintText: 'Nickname'),
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 400, vertical: 10),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                final String? nickname = nicknameController.text;
                context.read<RegistrationBloc>().add(register
                    ? Register(email: email, password: password, nickname: nickname!)
                    : LogIn(email: email, password: password));
              },
              child: Text(
                register ? 'Register' : 'Log in',
              )),
        ],
      ),
    );
  }
}

String formatException(Exception errorMessage) {
  final regex = RegExp(r'\[(.*?)\] ');
  final formattedMessage = errorMessage.toString().replaceFirst(regex, '');

  const exceptionPrefix = 'Exception: ';
  if (formattedMessage.startsWith(exceptionPrefix)) {
    return formattedMessage.replaceFirst(exceptionPrefix, '');
  }

  return formattedMessage;
}
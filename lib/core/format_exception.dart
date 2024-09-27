import 'package:flutter/material.dart';

String formatException(Exception errorMessage) {
  final regex = RegExp(r'\[(.*?)\] ');
  final formattedMessage = errorMessage.toString().replaceFirst(regex, '');

  const exceptionPrefix = 'Exception: ';
  if (formattedMessage.startsWith(exceptionPrefix)) {
    return formattedMessage.replaceFirst(exceptionPrefix, '');
  }

  return formattedMessage;
}

void showExceptionAlert(Exception e, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext content) {
        return AlertDialog(
          title: Text(formatException(e)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}

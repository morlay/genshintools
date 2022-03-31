import 'package:flutter/material.dart';

void showAlert(
  BuildContext context, {
  required Widget content,
  required Function() onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: content,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: const Text("确认"),
          ),
        ],
      );
    },
  );
}

void showSnackBar(
  BuildContext context, {
  required Widget content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content,
  ));
}

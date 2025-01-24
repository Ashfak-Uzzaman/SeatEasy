import 'package:flutter/material.dart';

void showSnackbar({required message, required context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

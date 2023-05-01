import 'package:flutter/material.dart';

enum SnackbarType {
  success,
  error,
}

SnackBar showSnackBar({
  required String content,
  type = SnackbarType.success,
}) {
  Color color;
  switch (type) {
    case SnackbarType.error:
      color = Colors.redAccent;
      break;
    default:
      color = Colors.green;
  }
  return SnackBar(
    content: Text(content),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
}

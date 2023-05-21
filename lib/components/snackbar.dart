import 'package:flutter/material.dart';
import 'package:traveller/utils/colors.dart';

enum SnackbarType {
  success,
  error,
  info,
}

SnackBar showSnackBar({
  required String content,
  type = SnackbarType.success,
}) {
  Color color;
  switch (type) {
    case SnackbarType.error:
      color = Colors.red[300] ?? Colors.red;
      break;
    case SnackbarType.info:
      color = AppColors.blue;
      break;
    default:
      color = AppColors.green;
  }
  return SnackBar(
    content: Text(content),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
}

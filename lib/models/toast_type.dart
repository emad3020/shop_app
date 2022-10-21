import 'package:flutter/material.dart';

enum ToastType {
  WARNING,
  ERROR,
  NORMAL,
}

abstract class ToastTypeFactory {
  factory ToastTypeFactory({required ToastType type}) {
    switch (type) {
      case ToastType.NORMAL:
        return NormatToast();
      case ToastType.ERROR:
        return ErrorToast();
      default:
        return NormatToast();
    }
  }

  Color getColor();
}

class NormatToast implements ToastTypeFactory {
  @override
  Color getColor() => Colors.green;
}

class ErrorToast implements ToastTypeFactory {
  @override
  Color getColor() => Colors.red;
}

class WarningToast implements ToastTypeFactory {
  @override
  Color getColor() => Colors.amber;
}

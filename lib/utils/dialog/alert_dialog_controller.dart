import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AlertDialogController {
  void showAlert(BuildContext context, Widget dialog);
  void dismissAlert(BuildContext context);
}

class AlertDialogControllerImpl implements AlertDialogController {
  void _showIOSAlert(BuildContext context, Widget dialog) {
    showCupertinoDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  void _showMaterialAlert(BuildContext context, Widget dialog) {
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  @override
  void showAlert(BuildContext context, Widget dialog) {
    if (Platform.isIOS) {
      _showIOSAlert(context, dialog);
    } else {
      _showMaterialAlert(context, dialog);
    }
  }

  @override
  void dismissAlert(BuildContext context) {
    Navigator.of(context).pop();
  }
}

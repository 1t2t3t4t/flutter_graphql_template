import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogBuilder {
  Widget _title;
  Widget? _content;
  final List<Widget> _actions = [];

  final bool forceMaterial;
  final bool forceCupertino;

  AlertDialogBuilder(String title,
      {this.forceMaterial = false, this.forceCupertino = false})
      : _title =
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold));

  factory AlertDialogBuilder.acknowledgeAlert(
      BuildContext context, String title,
      {String? content, Function? callback}) {
    final builder = AlertDialogBuilder(title);

    if (content != null) builder.setContent(content);
    builder.addAction(context,
        callback: (text) => callback?.call(), text: "Ok");

    return builder;
  }

  void setContent(String text) {
    _content = Text(text);
  }

  void setCustomContent(Widget content) {
    _content = Container(child: content);
  }

  void addAction(BuildContext context,
      {bool isDestructiveAction = false,
      required String text,
      void Function(String text)? callback,
      void Function()? poppedCallback}) {
    if (_shouldUseCupertino()) {
      _actions.add(CupertinoDialogAction(
          onPressed: () {
            if (callback != null) callback(text);
            Navigator.of(context).pop();
            poppedCallback?.call();
          },
          isDestructiveAction: isDestructiveAction,
          child: Text(text)));
    } else {
      _actions.add(TextButton(
        onPressed: () {
          if (callback != null) callback(text);
          Navigator.of(context).pop();
          poppedCallback?.call();
        },
        child: Text(
          text,
          style: TextStyle(
              color: isDestructiveAction ? Colors.redAccent : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ));
    }
  }

  Widget _iOSDialog() {
    return CupertinoAlertDialog(
      title: _title,
      content: _content,
      actions: _actions,
    );
  }

  Widget _materialDialog() {
    return AlertDialog(
      title: _title,
      content: _content,
      actions: _actions,
    );
  }

  Widget build() {
    assert(_actions.isNotEmpty, "Should have at least one action");
    return _shouldUseCupertino() ? _iOSDialog() : _materialDialog();
  }

  bool _shouldUseCupertino() {
    return (Platform.isIOS || forceCupertino) && !forceMaterial;
  }
}

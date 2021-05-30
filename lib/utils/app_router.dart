import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RouterParam {}

enum CustomPageRoute { fadeIn }

class FadeInPageRoute<T> extends PageRouteBuilder<T> {
  FadeInPageRoute(WidgetBuilder widgetBuilder)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) =>
                widgetBuilder(context),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
}

abstract class CustomRouter {
  Future<T?> push<T extends Object>(Widget targetRoute, BuildContext context,
      {bool replaceRoot = false, CustomPageRoute? customPageRoute});

  pop<T extends Object>(BuildContext context, [T values]);
}

class MainAppRouter implements CustomRouter {
  @override
  Future<T?> push<T extends Object>(Widget targetRoute, BuildContext context,
      {bool replaceRoot = false, CustomPageRoute? customPageRoute}) {
    return _navigate(context, targetRoute, replaceRoot, customPageRoute);
  }

  @override
  pop<T extends Object>(BuildContext context, [T? values]) {
    Navigator.of(context).pop(values);
  }

  Future<T?> _navigate<T extends Object>(BuildContext context,
      Widget targetRoute, bool replaceRoot, CustomPageRoute? customPageRoute) {
    if (replaceRoot) {
      return Navigator.of(context).pushAndRemoveUntil(
          _createRoute(targetRoute, customPageRoute), (r) => false);
    } else {
      return Navigator.of(context)
          .push(_createRoute(targetRoute, customPageRoute));
    }
  }

  PageRoute<T> _createRoute<T extends Object>(
      Widget targetRoute, CustomPageRoute? customPageRoute) {
    switch (customPageRoute) {
      case CustomPageRoute.fadeIn:
        return FadeInPageRoute((context) => targetRoute);
      default:
        return _platformSpecificRoute(targetRoute);
    }
  }

  PageRoute<T> _platformSpecificRoute<T extends Object>(Widget targetRoute) {
    try {
      if (Platform.isIOS) {
        return CupertinoPageRoute(builder: (context) => targetRoute);
      } else {
        return MaterialPageRoute(builder: (context) => targetRoute);
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => targetRoute);
    }
  }
}

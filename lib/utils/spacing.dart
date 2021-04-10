import 'package:flutter/material.dart';

enum Spacing { xs, s, m, l, xl }

extension SpacingValueGetter on Spacing {
  EdgeInsets get edgeInsetAll {
    return EdgeInsets.all(value);
  }

  BorderRadius get borderRadiusCircular {
    return BorderRadius.circular(value);
  }

  double get value {
    switch (this) {
      case Spacing.xs:
        return 4;
      case Spacing.s:
        return 8;
      case Spacing.m:
        return 16;
      case Spacing.l:
        return 24;
      case Spacing.xl:
        return 32;
    }
  }
}

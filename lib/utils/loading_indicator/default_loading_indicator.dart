import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_template/utils/spacing.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withAlpha(150)),
      child: Center(
          child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).indicatorColor),
          strokeWidth: Spacing.s.value,
        ),
      )),
    );
  }
}

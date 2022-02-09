import 'package:flutter/material.dart';

class DefaultThemes {
  DefaultThemes._();

  static BoxDecoration defaultContainerTheme(BuildContext context) => BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 3)],
      );
}

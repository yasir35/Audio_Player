import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get mediaQueryHeight => MediaQuery.of(this).size.height;
  double get mediaQueryWidth => MediaQuery.of(this).size.width;
}

extension PaddingExtension on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
}

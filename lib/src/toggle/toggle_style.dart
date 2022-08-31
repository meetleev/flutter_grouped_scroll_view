import 'package:flutter/widgets.dart';

class GroupedToggleStyle {
  /// An widget to use on this toggle when the toggle is on.
  final Widget? activeWidget;

  /// An color to use on this toggle's parent when the toggle is on.
  final Color? activeContainerColor;

  const GroupedToggleStyle({
    this.activeWidget,
    this.activeContainerColor,
  });
}

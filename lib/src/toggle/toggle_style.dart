import 'package:flutter/widgets.dart';
import 'toggle_type.dart';

class GroupedToggleStyle {
  /// toggleType used to toggle. Default [GroupedToggleType.checkbox].
  final GroupedToggleType toggleType;

  /// An widget to use on this toggle when the toggle is on.
  final Widget? activeWidget;

  /// An color to use on this toggle's parent when the toggle is on.
  final Color? activeContainerColor;

  const GroupedToggleStyle({
    this.activeWidget,
    this.activeContainerColor,
    this.toggleType = GroupedToggleType.checkbox,
  });
}

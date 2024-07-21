import 'package:flutter/widgets.dart';
import 'toggle_type.dart';

class GroupedToggleStyle {
  /// toggleType used to toggle. Default [GroupedToggleType.checkbox].
  final GroupedToggleType toggleType;

  /// How to align the child.
  final AlignmentGeometry toggleAlignment;

  /// default true, Whether this widget absorbs pointers during hit testing. Only toggleEnabled set true and takes effect
  final bool absorbChildPointer;

  /// Whether it is stacked, if it is stacked, the underlying elements are still displayed normally. Otherwise, they are not rendered.
  final bool isStacked;

  const GroupedToggleStyle(
      {this.toggleType = GroupedToggleType.checkbox,
      this.absorbChildPointer = true,
      this.toggleAlignment = Alignment.center,
      this.isStacked = true});
}

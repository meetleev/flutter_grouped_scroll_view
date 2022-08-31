import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/src/toggle/toggle_style.dart';
import 'package:grouped_scroll_view/src/toggle/toggle_controller.dart';
import 'package:grouped_scroll_view/src/toggle/toggle_type.dart';

typedef OnToggleChanged = void Function(int idx, bool isChecked);

class ToggleContainer extends StatefulWidget {
  final GroupedToggleController controller;
  final Widget body;
  final int index;

  const ToggleContainer({
    super.key,
    required this.controller,
    required this.body,
    required this.index,
  });

  @override
  State<StatefulWidget> createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  late GroupedToggleController _controller;
  late GroupedToggleStyle _toggleStyle;
  Size? bodySize;

  @override
  void initState() {
    super.initState();
    _buildController();
  }

  @override
  void didUpdateWidget(ToggleContainer oldWidget) {
    if (widget.controller != oldWidget.controller) {
      _buildController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _Toggle? toggle;
    return GestureDetector(
      onTap: () => _onSelected(toggle!, widget.index),
      child: AbsorbPointer(
          child: Stack(
        children: [
          widget.body,
          AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext __, Widget? _) {
                bool isChecked = widget.controller.selectedIndexes.contains(widget.index);
                toggle = _Toggle(
                  key: widget.key,
                  isChecked: isChecked,
                  activeWidget: _toggleStyle.activeWidget,
                );
                final Color activeContainerColor =
                    _toggleStyle.activeContainerColor ?? Colors.blue.withOpacity(0.5);
                return isChecked
                    ? SizedBox(
                        height: bodySize?.height,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: activeContainerColor),
                            ),
                            toggle!
                          ],
                        ),
                      )
                    : toggle!;
              }),
        ],
      )),
    );
  }

  _buildController() {
    _controller = widget.controller;
    _toggleStyle = _controller.toggleStyle ?? const GroupedToggleStyle();
  }

  void _onSelected(_Toggle toggle, int idx) {
    bodySize = context.size;
    if (GroupedToggleType.single == _controller.toggleType) {
      if (toggle.isChecked) return;
      _controller.radioSelected(idx);
    } else {
      toggle.isChecked ? _controller.unselected(idx) : _controller.selected(idx);
    }
    _controller.onToggleChanged?.call(idx, !toggle.isChecked);
  }
}

class _Toggle extends StatelessWidget {
  final bool isChecked;

  /// An widget to use on this toggle when the toggle is on.
  final Widget? activeWidget;

  const _Toggle({
    super.key,
    required this.isChecked,
    this.activeWidget,
  });

  @override
  Widget build(BuildContext context) {
    return isChecked
        ? (activeWidget ??
            Positioned(
                left: 5,
                top: 5,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  constraints: const BoxConstraints.tightFor(height: 25, width: 25),
                  child: const Icon(Icons.check),
                )))
        : Container();
  }
}

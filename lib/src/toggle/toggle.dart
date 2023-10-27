import 'package:flutter/material.dart';
import 'toggle_style.dart';
import 'toggle_controller.dart';
import 'toggle_type.dart';

typedef OnToggleChanged = void Function(int idx, bool isChecked);

const double _defaultListSize = 20;

class ToggleContainer extends StatefulWidget {
  final GroupedToggleController controller;
  final Widget body;
  final int index;
  final Size? size;
  final bool toggleEnabled;

  const ToggleContainer(
      {super.key,
      required this.controller,
      required this.body,
      required this.index,
      required this.toggleEnabled,
      this.size});

  @override
  State<StatefulWidget> createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  late GroupedToggleController _controller;
  late GroupedToggleStyle _toggleStyle;
  Size? _bodySize;

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _Toggle? toggle;
      return GestureDetector(
        onTap: () =>
            widget.toggleEnabled ? _onSelected(toggle!, widget.index) : {},
        child: AbsorbPointer(
            absorbing: _toggleStyle.absorbChildPointer,
            // absorbing: widget.toggleEnabled,
            child: Stack(
              children: [
                widget.body,
                AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext __, Widget? _) {
                      bool isChecked = widget.controller.selectedIndexes
                          .contains(widget.index);
                      toggle = _Toggle(
                        key: widget.key,
                        isChecked: isChecked,
                        activeWidget: _toggleStyle.activeWidget,
                      );
                      return isChecked
                          ? _selectedBuilder(constraints, toggle!)
                          : toggle!;
                    }),
              ],
            )),
      );
    });
  }

  _selectedBuilder(BoxConstraints constraints, _Toggle toggle) {
    final Color activeContainerColor =
        _toggleStyle.activeContainerColor ?? Colors.blue.withOpacity(0.5);
    return Container(
      width: (null == _bodySize)
          ? (constraints.hasTightWidth
              ? constraints.maxWidth
              : _defaultListSize)
          : _bodySize?.width,
      height: (null == _bodySize)
          ? (constraints.hasTightHeight
              ? constraints.maxHeight
              : _defaultListSize)
          : _bodySize?.height,
      decoration: BoxDecoration(color: activeContainerColor),
      child: toggle,
    );
  }

  _buildController() {
    _controller = widget.controller;
    _toggleStyle = _controller.toggleStyle ?? const GroupedToggleStyle();
    _bodySize ??= widget.size;
  }

  void _onSelected(_Toggle toggle, int idx) {
    _bodySize ??= context.size;
    if (GroupedToggleType.radio == _toggleStyle.toggleType) {
      if (toggle.isChecked) {
        return _controller.onToggleChanged?.call(idx, toggle.isChecked);
      }
      _controller.radioSelected(idx);
    } else {
      toggle.isChecked
          ? _controller.unselected(idx)
          : _controller.selected(idx);
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
                  constraints:
                      const BoxConstraints.tightFor(height: 25, width: 25),
                  child: const Icon(Icons.check),
                )))
        : Container();
  }
}

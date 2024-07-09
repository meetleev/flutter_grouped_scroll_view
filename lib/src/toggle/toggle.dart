import 'package:flutter/material.dart';
import 'toggle_style.dart';
import 'toggle_controller.dart';
import 'toggle_type.dart';

typedef OnToggleChanged = void Function(int idx, bool isChecked);

class ToggleContainer extends StatefulWidget {
  final GroupedToggleController controller;
  final Widget body;
  final int index;
  final bool toggleEnabled;

  const ToggleContainer(
      {super.key,
      required this.controller,
      required this.body,
      required this.index,
      required this.toggleEnabled});

  @override
  State<StatefulWidget> createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  late GroupedToggleController _controller;
  late GroupedToggleStyle _toggleStyle;
  final ValueNotifier<Size> _bodySizeValue = ValueNotifier(Size.zero);
  final GlobalKey _bodyKey = GlobalKey();

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback());
    return GestureDetector(
      onTap: () =>
          widget.toggleEnabled ? _onSelected(toggle!, widget.index) : {},
      child: AbsorbPointer(
          absorbing: widget.toggleEnabled && _toggleStyle.absorbChildPointer,
          child: Stack(
            alignment: _toggleStyle.toggleAlignment,
            children: [
              NotificationListener<SizeChangedLayoutNotification>(
                  onNotification: (SizeChangedLayoutNotification n) {
                    _postFrameCallback();
                    return true;
                  },
                  child: SizeChangedLayoutNotifier(
                      key: _bodyKey, child: widget.body)),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext __, Widget? _) {
                    bool isChecked = widget.controller.selectedIndexes
                        .contains(widget.index);
                    toggle = _Toggle(
                      index: widget.index,
                      isChecked: isChecked,
                      activeWidgetBuilder: _toggleStyle.activeWidgetBuilder,
                    );
                    return isChecked ? _selectedBuilder(toggle!) : toggle!;
                  }),
            ],
          )),
    );
  }

  Widget _selectedBuilder(_Toggle toggle) {
    final Color activeContainerColor =
        _toggleStyle.activeContainerColor ?? Colors.blue.withOpacity(0.3);
    return ValueListenableBuilder(
      valueListenable: _bodySizeValue,
      builder: (BuildContext context, Size value, Widget? child) {
        if (value.isEmpty) {
          return DecoratedBox(
              decoration: BoxDecoration(color: activeContainerColor),
              child: toggle);
        }
        return Container(
            width: _bodySizeValue.value.width,
            height: _bodySizeValue.value.height,
            decoration: BoxDecoration(color: activeContainerColor),
            child: toggle);
      },
    );
  }

  void _buildController() {
    _controller = widget.controller;
    _toggleStyle = _controller.toggleStyle ?? const GroupedToggleStyle();
  }

  void _onSelected(_Toggle toggle, int idx) {
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

  void _postFrameCallback() {
    final context = _bodyKey.currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    if (!_sizesAreEqual(size, _bodySizeValue.value)) {
      _bodySizeValue.value = size;
    }
  }

  @override
  void dispose() {
    _bodySizeValue.dispose();
    super.dispose();
  }

  static bool _sizesAreEqual(Size size1, Size size2,
      {double tolerance = 0.01}) {
    return (size1.width - size2.width).abs() < tolerance &&
        (size1.height - size2.height).abs() < tolerance;
  }
}

class _Toggle extends StatelessWidget {
  /// The index to use on this toggle
  final int index;
  final bool isChecked;

  /// Th builder to use on this toggle when the toggle is on.
  final Widget Function(int)? activeWidgetBuilder;

  const _Toggle(
      {required this.index, required this.isChecked, this.activeWidgetBuilder});

  @override
  Widget build(BuildContext context) {
    if (isChecked) {
      if (null != activeWidgetBuilder) {
        return activeWidgetBuilder!(index);
      }
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: const BoxDecoration(color: Colors.blue),
          constraints: const BoxConstraints.expand(height: 25, width: 25),
          child: const Icon(Icons.check),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

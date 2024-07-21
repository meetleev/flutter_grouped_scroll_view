import 'package:flutter/material.dart';
import 'toggle_style.dart';
import 'toggle_controller.dart';
import 'toggle_type.dart';

typedef OnToggleChanged = void Function(int idx, bool isChecked);

class ToggleContainer extends StatefulWidget {
  final GroupedToggleController controller;
  final Widget normal;
  final Widget? selected;
  final int index;
  final bool toggleEnabled;

  const ToggleContainer(
      {super.key,
      required this.controller,
      required this.normal,
      this.selected,
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
  bool _isSelected = false;

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
    return _toggleStyle.isStacked ? _buildStacked() : _buildStateContainer();
  }

  Widget _buildStateContainer() {
    _Toggle? toggle;
    return GestureDetector(
        onTap: () => widget.toggleEnabled ? _onSelected() : {},
        child: AbsorbPointer(
            absorbing: widget.toggleEnabled && _toggleStyle.absorbChildPointer,
            child: Container(
              alignment: _toggleStyle.toggleAlignment,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext __, Widget? _) {
                    _isSelected = widget.controller.selectedIndexes
                        .contains(widget.index);
                    toggle = _Toggle(
                        isChecked: _isSelected,
                        selected: widget.selected,
                        normal: widget.normal);
                    return toggle!;
                  }),
            )));
  }

  Widget _buildStacked() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback());
    return GestureDetector(
        onTap: () => widget.toggleEnabled ? _onSelected() : {},
        child: AbsorbPointer(
            absorbing: widget.toggleEnabled && _toggleStyle.absorbChildPointer,
            child: Stack(
              alignment: _toggleStyle.toggleAlignment,
              children: [
                NotificationListener<SizeChangedLayoutNotification>(
                    onNotification: (SizeChangedLayoutNotification n) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _postFrameCallback());
                      return true;
                    },
                    child: SizeChangedLayoutNotifier(
                        key: _bodyKey, child: widget.normal)),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext __, Widget? _) {
                      _isSelected = widget.controller.selectedIndexes
                          .contains(widget.index);
                      return _buildStackedSelectedBuilder(_Toggle(
                        isChecked: _isSelected,
                        selected: widget.selected,
                      ));
                    }),
              ],
            )));
  }

  Widget _buildStackedSelectedBuilder(_Toggle toggle) {
    return ValueListenableBuilder(
      valueListenable: _bodySizeValue,
      builder: (BuildContext context, Size value, Widget? child) {
        return value.isEmpty
            ? toggle
            : SizedBox(
                width: _bodySizeValue.value.width,
                height: _bodySizeValue.value.height,
                child: toggle);
      },
    );
  }

  void _buildController() {
    _controller = widget.controller;
    _toggleStyle = _controller.toggleStyle ?? const GroupedToggleStyle();
    _isSelected = widget.controller.selectedIndexes.contains(widget.index);
  }

  void _onSelected() {
    int idx = widget.index;
    if (GroupedToggleType.radio == _toggleStyle.toggleType) {
      if (_isSelected) {
        return _controller.onToggleChanged?.call(idx, _isSelected);
      }
      _controller.radioSelected(idx);
    } else {
      _isSelected ? _controller.unselected(idx) : _controller.selected(idx);
    }
    _controller.onToggleChanged?.call(idx, _isSelected);
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
  final bool isChecked;
  final Widget normal;

  /// Th builder to use on this toggle when the toggle is on.
  final Widget? selected;

  const _Toggle(
      {required this.isChecked,
      this.normal = const SizedBox.shrink(),
      this.selected});

  @override
  Widget build(BuildContext context) {
    if (isChecked) {
      if (null != selected) {
        return selected!;
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
    return normal;
  }
}

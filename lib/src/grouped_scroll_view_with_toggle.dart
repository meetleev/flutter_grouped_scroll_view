import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'grouped_scroll_view.dart';
import 'toggle/toggle.dart';
import 'options/grouped_scroll_view_options.dart';
import 'toggle/toggle_controller.dart';

class GroupedScrollViewWithToggle<T, H> extends StatefulWidget {
  /// data
  final List<T> data;

  /// Header
  final HeaderBuilder? headerBuilder;

  /// Footer
  final FooterBuilder? footerBuilder;

  /// Optional [Function] that helps sort the groups by comparing the [T] items.
  final Comparator<T>? itemsSorter;

  /// itemBuilder
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// The builder to use on this toggle when the toggle is on.
  final Widget Function(BuildContext context, T item)? itemSelectedBuilder;

  /// The delegate that controls the size and position of the children.
  final SliverGridDelegate? gridDelegate;

  /// separatorBuilder for [List]
  final IndexedWidgetBuilder? separatorBuilder;

  /// findChildIndexCallback for [SliverChildBuilderDelegate].
  final ChildIndexGetter? findChildIndexCallback;

  /// AutomaticKeepAlive for [SliverChildBuilderDelegate].
  final bool addAutomaticKeepAlives;

  /// addRepaintBoundaries for [SliverChildBuilderDelegate].
  final bool addRepaintBoundaries;

  /// addSemanticIndexes for [SliverChildBuilderDelegate].
  final bool addSemanticIndexes;

  /// semanticIndexOffset for [SliverChildBuilderDelegate].
  final int semanticIndexOffset;

  /// semanticIndexCallback for [SliverChildBuilderDelegate].
  final SemanticIndexCallback semanticIndexCallback;

  /// scrollDirection for [CustomScrollView]
  final Axis scrollDirection;

  /// reverse for [CustomScrollView]
  final bool reverse;

  /// controller for [CustomScrollView]
  final ScrollController? scrollController;

  /// primary for [CustomScrollView]
  final bool? primary;

  /// physics for [CustomScrollView]
  final ScrollPhysics? physics;

  /// scrollBehavior for [CustomScrollView]
  final ScrollBehavior? scrollBehavior;

  /// shrinkWrap for [CustomScrollView]
  final bool shrinkWrap;

  /// center for [CustomScrollView]
  final Key? center;

  /// anchor for [CustomScrollView]
  final double anchor;

  /// cacheExtent for [CustomScrollView]
  final double? cacheExtent;

  /// semanticChildCount for [CustomScrollView]
  final int? semanticChildCount;

  /// dragStartBehavior for [CustomScrollView]
  final DragStartBehavior dragStartBehavior;

  /// keyboardDismissBehavior for [CustomScrollView]
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// restorationId for [CustomScrollView]
  final String? restorationId;

  /// clipBehavior for [CustomScrollView]
  final Clip clipBehavior;

  /// Grouped by the groupedOptions.
  final GroupedScrollViewOptions<T, H>? groupedOptions;

  /// toggleController on edit mode.
  final GroupedToggleController? toggleController;

  /// If true, open edit mode. Default false;
  final bool toggleEnabled;

  /// used to determine whether the item can be selected
  final bool Function(T t)? toggleSelectable;

  const GroupedScrollViewWithToggle(
      {super.key,
      required this.data,
      this.headerBuilder,
      this.footerBuilder,
      required this.itemBuilder,
      this.itemsSorter,

      /// grid
      this.gridDelegate,

      /// list
      this.separatorBuilder,

      /// grouped
      this.groupedOptions,

      /// SliverChildBuilderDelegate
      this.findChildIndexCallback,
      this.addAutomaticKeepAlives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.semanticIndexCallback = kDefaultSemanticIndexCallback,
      this.semanticIndexOffset = 0,

      /// CustomScrollView
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.scrollController,
      this.primary,
      this.physics,
      this.scrollBehavior,
      this.shrinkWrap = false,
      this.center,
      this.anchor = 0.0,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge,

      /// toggle
      this.toggleController,
      this.toggleEnabled = false,
      this.toggleSelectable,
      this.itemSelectedBuilder});

  const GroupedScrollViewWithToggle.grid({
    super.key,
    required this.data,
    required this.itemBuilder,
    required this.gridDelegate,
    this.headerBuilder,
    this.footerBuilder,
    this.itemsSorter,

    /// grouped
    this.groupedOptions,

    /// toggle
    this.toggleController,
    this.toggleEnabled = false,
    this.itemSelectedBuilder,
    this.toggleSelectable,

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,

    /// CustomScrollView
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : separatorBuilder = null;

  const GroupedScrollViewWithToggle.list({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.itemsSorter,
    this.separatorBuilder,

    /// grouped
    this.groupedOptions,

    /// toggle
    this.toggleController,
    this.toggleEnabled = false,
    this.itemSelectedBuilder,
    this.toggleSelectable,

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,

    /// CustomScrollView
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : gridDelegate = null;

  @override
  State<GroupedScrollViewWithToggle> createState() =>
      _GroupedToggleScrollViewState<T, H>();
}

class _GroupedToggleScrollViewState<T, H>
    extends State<GroupedScrollViewWithToggle<T, H>> {
  GroupedToggleController? _defaultController;

  GroupedToggleController get _controller =>
      widget.toggleController ?? _defaultController!;

  @override
  void initState() {
    super.initState();
    if (null == widget.toggleController) {
      _defaultController = GroupedToggleController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedScrollView<T, H>(
      data: widget.data,
      itemBuilder: (BuildContext c, T item) => _itemBuilder(c, item),
      headerBuilder: widget.headerBuilder,
      footerBuilder: widget.footerBuilder,
      itemsSorter: widget.itemsSorter,
      gridDelegate: widget.gridDelegate,
      separatorBuilder: widget.separatorBuilder,
      groupedOptions: widget.groupedOptions,

      /// SliverChildBuilderDelegate
      findChildIndexCallback: widget.findChildIndexCallback,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      semanticIndexCallback: widget.semanticIndexCallback,
      semanticIndexOffset: widget.semanticIndexOffset,

      /// CustomScrollView
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      scrollController: widget.scrollController,
      primary: widget.primary,
      physics: widget.physics,
      scrollBehavior: widget.scrollBehavior,
      shrinkWrap: widget.shrinkWrap,
      center: widget.center,
      anchor: widget.anchor,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
    );
  }

  Widget _itemBuilder(BuildContext context, T item) {
    return ToggleContainer(
        toggleEnabled: widget.toggleEnabled,
        controller: _controller,
        normal: widget.itemBuilder(context, item),
        selected: widget.itemSelectedBuilder?.call(context, item),
        index: widget.data.indexOf(item),
        selectable: widget.toggleSelectable?.call(item));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(GroupedScrollViewWithToggle<T, H> oldWidget) {
    if (widget.toggleController != oldWidget.toggleController) {
      if (null != oldWidget.toggleController) {
        _defaultController?.dispose();
        _defaultController = null;
      } else {
        if (null == widget.toggleController) {
          _defaultController = GroupedToggleController();
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _defaultController?.dispose();
    super.dispose();
  }
}

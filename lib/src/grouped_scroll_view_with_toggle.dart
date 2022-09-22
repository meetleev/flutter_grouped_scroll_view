import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_scroll_view/src/toggle/toggle.dart';

import '../grouped_scroll_view.dart';

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

  /// The delegate that controls the size and position of the children.
  final SliverGridDelegate? gridDelegate;

  /// separatorBuilder for [List]
  final IndexedWidgetBuilder? separatorBuilder;

  /// findChildIndexCallback for [SliverChildBuilderDelegate].
  final ChildIndexGetter? findChildIndexCallback;

  /// addAutomaticKeepAlives for [SliverChildBuilderDelegate].
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

  /// The toggleItemSize is used for the size of the checkbox container in the list.
  final Size? toggleItemSize;

  /// If true, open edit mode. Default false;
  final bool toggleEnabled;

  const GroupedScrollViewWithToggle({
    Key? key,
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
    this.toggleItemSize,
    this.toggleEnabled = false,
  }) : super(key: key);

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
  })  : separatorBuilder = null,
        toggleItemSize = null;

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
    this.toggleItemSize,
    this.toggleEnabled = false,

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
  GroupedToggleController? _controller;

  @override
  void initState() {
    super.initState();
    _controller ??= widget.toggleController ?? GroupedToggleController();
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
      size: widget.toggleItemSize,
      controller: _controller!,
      body: widget.itemBuilder(
        context,
        item,
      ),
      index: widget.data.indexOf(item),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(GroupedScrollViewWithToggle<T, H> oldWidget) {
    if (widget.toggleController != oldWidget.toggleController) {
      if (null != widget.toggleController) {
        oldWidget.toggleController?.dispose();
        _controller = widget.toggleController;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/src/grouped_scroll_view_options.dart';
import 'package:grouped_scroll_view/src/toggle/toggle.dart';
import 'package:grouped_scroll_view/src/toggle/toggle_controller.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'dart:math' as math;

int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;

@immutable
class GroupedScrollView<T, H> extends StatelessWidget {
  /// data
  final List<T> data;

  /// Header
  final Widget Function(BuildContext context)? headerBuilder;

  /// Footer
  final Widget Function(BuildContext context)? footerBuilder;

  /// Optional [Function] that helps sort the groups by comparing the [T] items.
  final Comparator<T>? itemsSorter;

  /// itemBuilder
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// The delegate that controls the size and position of the children.
  final SliverGridDelegate? gridDelegate;

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

  /// separatorBuilder for [List]
  final IndexedWidgetBuilder? separatorBuilder;

  /// toggleController on edit mode. If this not null, open edit mode.
  final GroupedToggleController? toggleController;

  /// The toggleItemSize is used for the size of the checkbox container in the list.
  final Size? toggleItemSize;

  final GroupedScrollViewOptions<T, H>? groupedOptions;

  const GroupedScrollView({
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
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
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
  }) : super(key: key);

  const GroupedScrollView.grid({
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

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
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

  const GroupedScrollView.list({
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

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
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
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: scrollController,
      primary: primary,
      physics: physics,
      scrollBehavior: scrollBehavior,
      shrinkWrap: shrinkWrap,
      center: center,
      anchor: anchor,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      slivers: null != groupedOptions
          ? _buildGroupMode(context)
          : _buildNormalMode(context),
    );
  }

  List<Widget> _buildNormalMode(BuildContext context) {
    if (itemsSorter != null) {
      data.sort(itemsSorter);
    }
    List<Widget> section = [];
    if (null != headerBuilder) {
      section.add(SliverToBoxAdapter(child: headerBuilder!(context)));
    }
    section.add(null != gridDelegate
        ? SliverGrid(
            delegate: _buildSliverChildDelegate(data),
            gridDelegate: gridDelegate!)
        : SliverList(delegate: _buildSliverChildDelegate(data)));
    if (null != footerBuilder) {
      section.add(SliverToBoxAdapter(
        child: footerBuilder!(context),
      ));
    }
    return section;
  }

  List<Widget> _buildGroupMode(BuildContext context) {
    final options = groupedOptions!;
    List<Widget> slivers = [];
    Map<H, List<T>> groupItems = groupBy(data, options.itemGrouper);
    List<H> keys = groupItems.keys.toList();
    if (options.stickyHeaderSorter != null) {
      keys.sort(options.stickyHeaderSorter);
    }
    final groups = keys.length;
    for (var i = 0; i < groups; i++) {
      H header = keys[i];
      List<T> items = groupItems[header]!;
      if (itemsSorter != null) {
        items.sort(itemsSorter);
      }
      List<Widget> section = [];
      if (0 == i && null != headerBuilder) section.add(headerBuilder!(context));
      section.add(SliverPinnedHeader(
        child: options.stickyHeaderBuilder(context, header, i),
      ));
      section.add(null != gridDelegate
          ? SliverGrid(
              delegate: _buildSliverChildDelegate(items),
              gridDelegate: gridDelegate!)
          : SliverList(delegate: _buildSliverChildDelegate(items)));
      if (groups - 1 == i && null != footerBuilder) {
        section.add(footerBuilder!(context));
      }
      slivers.add(
          MultiSliver(key: key, pushPinnedChildren: true, children: section));
    }
    return slivers;
  }

  _buildSliverChildDelegate(List<T> items) {
    return SliverChildBuilderDelegate(
        (context, idx) => _sliverChildBuilder(context, idx, items),
        addRepaintBoundaries: addRepaintBoundaries,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addSemanticIndexes: addSemanticIndexes,
        findChildIndexCallback: findChildIndexCallback,
        semanticIndexOffset: semanticIndexOffset,
        semanticIndexCallback: semanticIndexCallback,
        childCount: _isHasListSeparatorBuilder()
            ? _computeActualChildCount(items.length)
            : items.length);
  }

  // Helper method to compute the actual child count for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  _isHasListSeparatorBuilder() {
    return null == gridDelegate && null != separatorBuilder;
  }

  _sliverChildBuilder(BuildContext context, int index, List<T> items) {
    if (_isHasListSeparatorBuilder()) {
      final int itemIndex = index ~/ 2;
      return index.isEven
          ? _sliverChildBuilderWithoutSeparator(context, items[itemIndex])
          : separatorBuilder!(context, itemIndex);
    }
    return _sliverChildBuilderWithoutSeparator(context, items[index]);
  }

  _sliverChildBuilderWithoutSeparator(BuildContext context, T item) {
    return null != toggleController
        ? ToggleContainer(
            size: toggleItemSize,
            controller: toggleController!,
            body: itemBuilder(
              context,
              item,
            ),
            index: data.indexOf(item),
          )
        : itemBuilder(context, item);
  }
}

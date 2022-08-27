import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;

@immutable
class GroupedScrollView<T, H> extends StatelessWidget {
  /// data
  final List<T> data;

  /// Header
  final Widget Function(BuildContext context)? headerBuilder;

  /// Footer
  final Widget Function(BuildContext context)? footerBuilder;

  /// Optional [Function] that helps sort the groups by comparing the [H] stickyHeaders.
  final Comparator<H>? stickyHeaderSorter;

  /// Optional [Function] that helps sort the groups by comparing the [T] items.
  final Comparator<T>? itemsSorter;

  /// stickyHeaderBuilder
  final Widget Function(BuildContext context, H header, int idx)
      stickyHeaderBuilder;

  /// itemBuilder
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// itemGrouper
  final H Function(T item) itemGrouper;

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
  final ScrollController? controller;

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

  const GroupedScrollView({
    Key? key,
    required this.data,
    this.headerBuilder,
    this.footerBuilder,
    required this.stickyHeaderBuilder,
    required this.itemBuilder,
    required this.itemGrouper,
    this.gridDelegate,

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,
    this.stickyHeaderSorter,
    this.itemsSorter,

    /// CustomScrollView
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
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
  }) : super(key: key);

  const GroupedScrollView.grid({
    super.key,
    required this.data,
    required this.stickyHeaderBuilder,
    required this.itemBuilder,
    required this.itemGrouper,
    required this.gridDelegate,
    this.headerBuilder,
    this.footerBuilder,

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,
    this.stickyHeaderSorter,
    this.itemsSorter,

    /// CustomScrollView
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
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
  });

  const GroupedScrollView.list({
    super.key,
    required this.data,
    required this.stickyHeaderBuilder,
    required this.itemBuilder,
    required this.itemGrouper,
    this.headerBuilder,
    this.footerBuilder,

    /// SliverChildBuilderDelegate
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,
    this.stickyHeaderSorter,
    this.itemsSorter,

    /// CustomScrollView
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
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
    Map<H, List<T>> groupItems = groupBy(data, itemGrouper);
    List<H> keys = groupItems.keys.toList();
    if (stickyHeaderSorter != null) {
      keys.sort(stickyHeaderSorter);
    }
    List<Widget> slivers = [];
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
        child: stickyHeaderBuilder(context, header, i),
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
    return CustomScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
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
      slivers: slivers,
    );
  }

  _buildSliverChildDelegate(List<T> items) {
    return SliverChildBuilderDelegate(
        (context, idx) => itemBuilder(context, items[idx]),
        addRepaintBoundaries: addRepaintBoundaries,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addSemanticIndexes: addSemanticIndexes,
        findChildIndexCallback: findChildIndexCallback,
        semanticIndexOffset: semanticIndexOffset,
        semanticIndexCallback: semanticIndexCallback,
        childCount: items.length);
  }
}

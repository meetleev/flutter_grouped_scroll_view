import 'package:flutter/cupertino.dart';

class GroupedScrollViewOptions<T, H> {
  /// Optional [Function] that helps sort the groups by comparing the [H] stickyHeaders.
  final Comparator<H>? stickyHeaderSorter;

  /// stickyHeaderBuilder
  final Widget Function(BuildContext context, H header, int groupedIndex)
      stickyHeaderBuilder;

  /// sectionFooterBuilder
  final Widget Function(BuildContext context, H header, int groupedIndex)?
      sectionFooterBuilder;

  /// itemGrouper
  final H Function(T item) itemGrouper;
  GroupedScrollViewOptions(
      {required this.stickyHeaderBuilder,
      this.sectionFooterBuilder,
      required this.itemGrouper,
      this.stickyHeaderSorter});
}

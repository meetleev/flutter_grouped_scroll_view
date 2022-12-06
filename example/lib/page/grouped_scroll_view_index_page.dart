import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

import '../test_data_cache.dart';

class GroupedScrollViewIndexTestPage extends StatefulWidget {
  const GroupedScrollViewIndexTestPage({super.key});

  @override
  State<StatefulWidget> createState() => _GroupedScrollViewIndexTestPageState();
}

class _GroupedScrollViewIndexTestPageState
    extends State<GroupedScrollViewIndexTestPage> {
  final int _crossAxisCount = 3;
  final Map<int, int> _groupedTotalMap = {};
  late int _curGroupedIndex = 0;
  late int _groupedItemIndex = 0;

  _calculateAccumulatedItemIndex() {
    int index = 0;
    for (int i = 0; i < _curGroupedIndex; i++) {
      if (_groupedTotalMap.containsKey(i)) {
        index += _groupedTotalMap[i]!;
      }
    }
    return index + _groupedItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('index Test'),
      ),
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return GroupedScrollView.grid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: _crossAxisCount),
      groupedOptions: GroupedScrollViewOptions(itemGrouper: (Person person) {
        return person.birthYear;
      }, stickyHeaderBuilder:
          (BuildContext context, int year, int groupedIndex) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints.tightFor(height: 30),
          child: Text(
            '$year',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }),
      itemAtIndex: (int index, int total, int groupedIndex) {
        if (!_groupedTotalMap.containsKey(groupedIndex)) {
          _groupedTotalMap[groupedIndex] = total;
        }
        _curGroupedIndex = groupedIndex;
        _groupedItemIndex = index;
      },
      itemBuilder: (BuildContext context, Person item) {
        return Container(
          color: Colors.lightGreen,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Positioned(
                  bottom: 5,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: Column(
                      children: [
                        Text(
                          'GroupedItemIdx:$_groupedItemIndex',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          'AccumulatedIdx:${_calculateAccumulatedItemIndex()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        );
      },
      data: DataCache.instance.persons,
    );
  }
}

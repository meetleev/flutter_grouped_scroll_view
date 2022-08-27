import 'package:example/test_data_cache.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class GroupedGridViewTestPage extends StatefulWidget {
  final int crossAxisCount;

  const GroupedGridViewTestPage({super.key, required this.crossAxisCount});

  @override
  State<GroupedGridViewTestPage> createState() =>
      _GroupedGridViewTestPageState();
}

class _GroupedGridViewTestPageState extends State<GroupedGridViewTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedScrollView.grid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: widget.crossAxisCount),
        itemGrouper: (Person person) {
          return person.birthYear;
        },
        stickyHeaderBuilder: (BuildContext context, int year, int idx) =>
            Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints.tightFor(height: 30),
          child: Text(
            '$year',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (BuildContext context, Person item) {
          return Container(
            color: Colors.lightGreen,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints.tightFor(width: 100),
            child: Center(
              child: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        data: DataCache.instance.persons,
        headerBuilder: (BuildContext context) => Column(
          children: const [
            Divider(
              thickness: 5,
            ),
            Center(
              child: Text(
                'CustomHeader',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 5,
            ),
          ],
        ),
        footerBuilder: (BuildContext context) => Column(
          children: const [
            Divider(
              thickness: 5,
            ),
            Center(
              child: Text(
                'CustomFooter',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 5,
            ),
          ],
        ),
      ),
    );
  }
}

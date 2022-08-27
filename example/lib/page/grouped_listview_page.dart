import 'package:example/test_data_cache.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class GroupedListViewTestPage extends StatefulWidget {
  const GroupedListViewTestPage({super.key});

  @override
  State<GroupedListViewTestPage> createState() =>
      _GroupedListViewTestPageState();
}

class _GroupedListViewTestPageState extends State<GroupedListViewTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedScrollView.list(
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
            constraints: const BoxConstraints.expand(height: 35),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints.expand(height: 30),
                  color: Colors.lightGreen,
                  child: Center(
                    child: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ), //SizedBox(height: 5,)
              ],
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

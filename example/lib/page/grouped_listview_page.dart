import 'package:example/test_data_cache.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class GroupedListViewTestPage extends StatefulWidget {
  final String title;
  final GroupedToggleType? toggleType;
  final bool grouped;

  const GroupedListViewTestPage({super.key, required this.title, this.toggleType, this.grouped = true});

  @override
  State<GroupedListViewTestPage> createState() => _GroupedListViewTestPageState();
}

class _GroupedListViewTestPageState extends State<GroupedListViewTestPage> {
  GroupedToggleController? _toggleController;

  @override
  Widget build(BuildContext context) {
    if (null != widget.toggleType) {
      _toggleController = GroupedToggleController(
          toggleType: widget.toggleType!,
          onToggleChanged: (int idx, bool selected) =>
              print('GroupedListViewTestPage:onToggleChanged===>idx:[$idx]--selected:[$selected]'),
          toggleStyle: GroupedToggleStyle(
              activeWidget: Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    constraints: const BoxConstraints.tightFor(height: 25, width: 25),
                    child: const Icon(Icons.check),
                  ))));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GroupedScrollView.list(
        groupedOptions: widget.grouped
            ? GroupedScrollViewOptions(
                itemGrouper: (Person person) {
                  return person.birthYear;
                },
                stickyHeaderBuilder: (BuildContext context, int year, int idx) => Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints.tightFor(height: 30),
                      child: Text(
                        '$year',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
            : null,
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
        toggleController: _toggleController,
      ),
    );
  }

  @override
  void dispose() {
    _toggleController?.dispose();
    super.dispose();
  }
}

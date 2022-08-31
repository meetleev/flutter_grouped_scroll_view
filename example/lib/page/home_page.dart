import 'package:example/page/grouped_gridview_page.dart';
import 'package:example/page/grouped_listview_page.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('video test'),
      ),
      body: ListView(
        children: [..._buildExampleWidgets()],
      ),
    );
  }

  List<Widget> _buildExampleWidgets() {
    return [
      const SizedBox(
        height: 10,
      ),
      _buildExampleElementWidget('GroupedGrid', () {
        _navigateToPage(const GroupedGridViewTestPage(
          crossAxisCount: 3,
          title: 'GroupedGrid',
        ));
      }),
      _buildExampleElementWidget('GroupedList', () {
        _navigateToPage(const GroupedListViewTestPage(
          title: 'GroupedList',
        ));
      }),
      _buildExampleElementWidget('Multiple choice for groupedGrid', () {
        _navigateToPage(const GroupedGridViewTestPage(
          crossAxisCount: 3,
          toggleType: GroupedToggleType.multiple,
          title: 'multiple choice for GroupedGrid',
        ));
      }),
      _buildExampleElementWidget('Multiple choice for groupedList', () {
        _navigateToPage(const GroupedListViewTestPage(
          toggleType: GroupedToggleType.multiple,
          title: 'multiple choice for groupedList',
        ));
      }),
      _buildExampleElementWidget('Single choice for groupedGrid', () {
        _navigateToPage(const GroupedGridViewTestPage(
          crossAxisCount: 3,
          toggleType: GroupedToggleType.single,
          title: 'single choice for GroupedGrid',
        ));
      }),
      _buildExampleElementWidget('Single choice for groupedList', () {
        _navigateToPage(const GroupedListViewTestPage(
          toggleType: GroupedToggleType.single,
          title: 'single choice for groupedList',
        ));
      }),
      _buildExampleElementWidget('Single choice for grid', () {
        _navigateToPage(const GroupedGridViewTestPage(
          grouped: false,
          crossAxisCount: 3,
          toggleType: GroupedToggleType.single,
          title: 'single choice for grid',
        ));
      }),
      _buildExampleElementWidget('Single choice for list', () {
        _navigateToPage(const GroupedListViewTestPage(
          grouped: false,
          toggleType: GroupedToggleType.single,
          title: 'single choice for list',
        ));
      }),
    ];
  }

  Future _navigateToPage(Widget routeWidget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routeWidget),
    );
  }

  _buildExampleElementWidget(String name, Function() onClicked) {
    return InkWell(
      onTap: onClicked,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.orange,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

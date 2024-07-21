import 'package:example/page/grouped_scroll_view_index_page.dart';
import 'package:example/page/grouped_scroll_view_page.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

import 'grouped_scroll_view_with_toggle_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

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
        title: const Text('Grouped scrollView test'),
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
        _navigateToPage(const GroupedScrollViewTestPage(
          crossAxisCount: 3,
          title: 'GroupedGrid',
        ));
      }),
      _buildExampleElementWidget('GroupedList', () {
        _navigateToPage(const GroupedScrollViewTestPage(
          title: 'GroupedList',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a groupedGrid on editMode', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          crossAxisCount: 3,
          toggleType: GroupedToggleType.checkbox,
          editModeTest: true,
          title: 'Checkboxes in a groupedGrid on editMode',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a list on editMode', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          toggleType: GroupedToggleType.checkbox,
          editModeTest: true,
          title: 'Checkboxes in a list on editMode',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a groupedGrid', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          crossAxisCount: 3,
          toggleType: GroupedToggleType.checkbox,
          title: 'Checkboxes in a groupedGrid',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a groupedList', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          toggleType: GroupedToggleType.checkbox,
          title: 'Checkboxes in a groupedList',
        ));
      }),
      _buildExampleElementWidget('Radios in a groupedGrid', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          crossAxisCount: 3,
          toggleType: GroupedToggleType.radio,
          title: 'Radios in a groupedGrid',
        ));
      }),
      _buildExampleElementWidget('Radios in a groupedList', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          toggleType: GroupedToggleType.radio,
          title: 'Radios in a groupedList',
        ));
      }),
      _buildExampleElementWidget('Radios in a grid', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: false,
          crossAxisCount: 3,
          toggleType: GroupedToggleType.radio,
          title: 'Radios in a grid',
        ));
      }),
      _buildExampleElementWidget('Radios in a list', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: false,
          toggleType: GroupedToggleType.radio,
          title: 'Radios in a list',
        ));
      }),
      _buildExampleElementWidget('not stacked, radios in a list', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: false,
          toggleType: GroupedToggleType.radio,
          isToggleStacked: false,
          title: 'not stacked, Radios in a list',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a grid', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: false,
          crossAxisCount: 3,
          toggleType: GroupedToggleType.checkbox,
          title: 'Checkboxes in the grid',
        ));
      }),
      _buildExampleElementWidget('Checkboxes in a list', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: false,
          toggleType: GroupedToggleType.checkbox,
          title: 'Checkboxes in a list',
        ));
      }),
      _buildExampleElementWidget('Separated in a list', () {
        _navigateToPage(const GroupedScrollViewWithToggleTestPage(
          grouped: true,
          separated: true,
          toggleType: GroupedToggleType.radio,
          title: 'Separated in a list',
        ));
      }),
      _buildExampleElementWidget('index test in a grid', () {
        _navigateToPage(const GroupedScrollViewIndexTestPage());
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

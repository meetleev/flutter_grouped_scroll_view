import 'package:example/test_data_cache.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class GroupedScrollViewTestPage extends StatelessWidget {
  final int crossAxisCount;
  final String title;
  final bool grouped;
  final bool separated;

  const GroupedScrollViewTestPage({
    super.key,
    required this.title,
    this.crossAxisCount = 0,
    this.grouped = true,
    this.separated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: 0 < crossAxisCount ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return GroupedScrollView.list(
      groupedOptions: grouped
          ? GroupedScrollViewOptions(
              itemGrouper: (Person person) {
                return person.birthYear;
              },
              stickyHeaderBuilder:
                  (BuildContext context, int year, int groupedIndex) =>
                      Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        constraints: const BoxConstraints.tightFor(height: 30),
                        child: Text(
                          '$year',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
              sectionFooterBuilder:
                  (BuildContext cxt, int year, int groupedIndex) =>
                      _buildSectionFooter(cxt, year, groupedIndex))
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
      headerBuilder: (BuildContext context) => const Column(
        children: [
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
      footerBuilder: (BuildContext context) => const Column(
        children: [
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
      separatorBuilder: separated
          ? (BuildContext context, int index) => const SizedBox(
                height: 20,
              )
          : null,
    );
  }

  Widget _buildGridView() {
    return GroupedScrollView.grid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: crossAxisCount),
      groupedOptions: grouped
          ? GroupedScrollViewOptions(
              itemGrouper: (Person person) {
                return person.birthYear;
              },
              stickyHeaderBuilder:
                  (BuildContext context, int year, int groupedIndex) =>
                      Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        constraints: const BoxConstraints.tightFor(height: 30),
                        child: Text(
                          '$year',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
              sectionFooterBuilder:
                  (BuildContext cxt, int year, int groupedIndex) =>
                      _buildSectionFooter(cxt, year, groupedIndex))
          : null,
      itemBuilder: (BuildContext context, Person item) {
        return Container(
          color: Colors.lightGreen,
          child: Center(
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      data: DataCache.instance.persons,
      headerBuilder: (BuildContext context) => const Column(
        children: [
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
      footerBuilder: (BuildContext context) => const Column(
        children: [
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
    );
  }

  Widget _buildSectionFooter(BuildContext cxt, int year, int groupedIndex) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints.tightFor(height: 30),
      child: Center(
        child: Text(
          'SectionFooter - $year',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

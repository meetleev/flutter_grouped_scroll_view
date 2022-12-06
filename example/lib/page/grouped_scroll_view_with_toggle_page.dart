import 'package:example/test_data_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class GroupedScrollViewWithToggleTestPage extends StatefulWidget {
  final int crossAxisCount;
  final GroupedToggleType? toggleType;
  final String title;
  final bool grouped;
  final bool editModeTest;
  final bool separated;

  const GroupedScrollViewWithToggleTestPage(
      {super.key,
      required this.title,
      this.crossAxisCount = 0,
      this.toggleType,
      this.grouped = true,
      this.editModeTest = false,
      this.separated = false});

  @override
  State<GroupedScrollViewWithToggleTestPage> createState() =>
      _GroupedScrollViewWithToggleTestPageState();
}

class _GroupedScrollViewWithToggleTestPageState
    extends State<GroupedScrollViewWithToggleTestPage> {
  GroupedToggleController? _toggleController;
  bool _toggleEnabled = true;

  @override
  void initState() {
    super.initState();
    if (widget.editModeTest) _toggleEnabled = false;
    _buildController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _buildController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: 0 < widget.crossAxisCount ? _buildGridView() : _buildListView(),
    );
  }

  @override
  void dispose() {
    _toggleController = null;
    super.dispose();
  }

  void _buildController() {
    if (null != widget.toggleType) {
      _toggleController ??= GroupedToggleController(
        toggleStyle: GroupedToggleStyle(
            toggleType: widget.toggleType!,
            activeWidget: 0 < widget.crossAxisCount
                ? null
                : Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.blue),
                      constraints:
                          const BoxConstraints.tightFor(height: 25, width: 25),
                      child: const Icon(Icons.check),
                    ))),
        onToggleChanged: (int idx, bool selected) {
          if (kDebugMode) {
            print(
                'GroupedScrollViewWithToggleTestPage:onToggleChanged===>idx:[$idx]--selected:[$selected]');
          }
          if (kDebugMode) {
            print(
                'GroupedScrollViewWithToggleTestPage===> all selected indexes:[${_toggleController!.selectedIndexes}]');
          }
          setState(() {});
        },
      );
    }
  }

  AppBar _buildAppBar() {
    if (widget.editModeTest) {
      return AppBar(
        title: _toggleEnabled
            ? Text(
                'Selected ${_toggleController!.selectedIndexes.length} items')
            : Text(widget.title),
        centerTitle: _toggleEnabled,
        actions: [
          IconButton(
              onPressed: () {
                if (_toggleEnabled) {
                  _toggleController!.selectedIndexes.clear();
                }
                _toggleEnabled = !_toggleEnabled;
                setState(() {});
              },
              icon:
                  Icon(_toggleEnabled ? Icons.check : Icons.check_box_outlined))
        ],
      );
    }
    return AppBar(
      title: Text(widget.title),
    );
  }

  _buildGridView() {
    return GroupedScrollViewWithToggle.grid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: widget.crossAxisCount),
      groupedOptions: widget.grouped
          ? GroupedScrollViewOptions(
              itemGrouper: (Person person) {
                return person.birthYear;
              },
              stickyHeaderBuilder:
                  (BuildContext context, int year, int groupedIndex) =>
                      Container(
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
          color: Colors.lightGreen,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      data: DataCache.instance.persons,
      headerBuilder: (BuildContext context) => _toggleEnabled
          ? Container()
          : Column(
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
      toggleEnabled: _toggleEnabled,
    );
  }

  _buildListView() {
    return GroupedScrollViewWithToggle.list(
      groupedOptions: widget.grouped
          ? GroupedScrollViewOptions(
              itemGrouper: (Person person) {
                return person.birthYear;
              },
              stickyHeaderBuilder:
                  (BuildContext context, int year, int groupedIndex) =>
                      Container(
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
      separatorBuilder: widget.separated
          ? (BuildContext context, int index) => const SizedBox(
                height: 20,
              )
          : null,
      toggleController: _toggleController,
      toggleEnabled: _toggleEnabled,
    );
  }
}

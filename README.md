# grouped_scroll_view
[![Pub](https://img.shields.io/pub/v/grouped_scroll_view.svg?style=flat-square)](https://pub.dev/packages/grouped_scroll_view)
[![support](https://img.shields.io/badge/platform-android%20|%20ios%20|%20web%20|%20macos%20|%20windows%20|%20linux%20-blue.svg)](https://pub.dev/packages/grouped_scroll_view)

A package to display a grouped list of items. Provide a List, a grouper, and let it display it as a ListView, a GridView or anything else. Grouped by headers.
## Preview

<table>
    <tr>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_grid.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_list.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_grid_checkBox.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_list_checkBox.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_grid_radio.gif" alt=""/></td>
    </tr>
    <tr>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grouped_list_radio.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grid_checkBox.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/list_checkBox.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/grid_radio.gif" alt=""/></td>
        <td><img width="130px" src="https://github.com/GLeeWei/static_resources/raw/main/grouped_scroll_view/list_radio.gif" alt=""/></td>
    </tr>
</table>


## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  grouped_scroll_view: <latest_version>
```

## Features
* support stickyHeader
* support customHeader
* support customFooter
* Support **checkbox** or **radio** in the list

## Usage
* grouped for grid view
``` dart
GroupedScrollView.grid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: widget.crossAxisCount),
        groupedOptions: GroupedScrollViewOptions(
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
                    )
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
      )
```

* grouped for list view
``` dart
    GroupedScrollView.list(
            groupedOptions: GroupedScrollViewOptions(
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
                )),
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
          )
```
## Additional information
* If the list needs to support checkbox or radio, please set the toggleController
``` dart
GroupedScrollView.grid({
    data: List<T>,
    itemBuilder: (BuildContext context, T item) { /*...*/},
    toggleController: GroupedToggleController(
        toggleType: GroupedToggleType.multiple,
        onToggleChanged: (int idx, bool selected) {
          // ...
        },
        toggleStyle: GroupedToggleStyle(),
    ),
    // ...
});
```

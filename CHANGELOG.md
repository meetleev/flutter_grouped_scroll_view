## 0.1.6

* rewrite toggle. For example, see [grouped_scroll_view_with_toggle_page](./example/lib/page/grouped_scroll_view_with_toggle_page.dart)
  - removed 'activeWidgetBuilder', use 'itemSelectedBuilder' instead. 
  - removed 'activeContainerColor'
  - added 'isStacked' option in 'ToggleStyle'. Whether it is stacked, if it is stacked, the underlying elements are still displayed normally. Otherwise, they are not rendered.


## 0.1.5

* removed 'activeWidget' on toggle mode, use 'activeWidgetBuilder' instead.
* removed 'toggleItemSize' on toggle mode, automatically calculate the size with sizebox
* fixed some bugs

## 0.1.3

* added topics

## 0.1.2

* absorbChildPointer only takes effect when toggleEnabled on toggle mode
* rewrite default selected widget

## 0.1.1

* Added sectionFooterBuilder option for adding section footers.

## 0.1.0

* add absorbChildPointer option for toggle mode

## 0.0.10

* upgrade sliver_tools to 0.2.12
* upgrade collection to 1.17.1

## 0.0.9

* add ItemAtIndex callback used to return grouped index.

## 0.0.8+5

* remove toggleController dispose on toggle_test when the widget dispose .

## 0.0.8+1

* Modify the assignment error of _toggleController in GroupedScrollViewWithToggle

## 0.0.8

* add new class **GroupedScrollViewWithToggle**, toggle separate from the GroupedScrollView.

## 0.0.7

* Supports separatorBuilder in a list

## 0.0.5

* Supports checkbox or radio in a list
* Supports normal list/grid
* Supports custom toggleStyle of selected

## 0.0.2

* more of the public API has dartdoc comments.

## 0.0.1

* initial release.

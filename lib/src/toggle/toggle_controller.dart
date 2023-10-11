import 'package:flutter/widgets.dart';
import 'toggle.dart';
import 'toggle_style.dart';

class GroupedToggleController extends ChangeNotifier {
  /// toggleStyle used to custom toggle.
  final GroupedToggleStyle? toggleStyle;

  /// onToggleChanged used to toggle.
  final OnToggleChanged? onToggleChanged;

  final Set<int> _selectedIndexes;

  /// selected indexes
  Set<int> get selectedIndexes => _selectedIndexes;

  GroupedToggleController(
      {this.toggleStyle,
      this.onToggleChanged,
      List<int> selectedIndexes = const []})
      : _selectedIndexes = selectedIndexes.toSet();

  /// selected index on only single type
  radioSelected(int index) {
    _selectedIndexes.clear();
    _selectedIndexes.add(index);
    notifyListeners();
  }

  /// selected index
  selected(int index) {
    if (_selectedIndexes.contains(index)) return;
    _selectedIndexes.add(index);
    notifyListeners();
  }

  /// unselected index
  unselected(int index) {
    if (!_selectedIndexes.contains(index)) return;
    _selectedIndexes.remove(index);
    notifyListeners();
  }
}

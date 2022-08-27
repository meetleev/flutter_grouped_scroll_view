import 'dart:math';

class Person {
  final String name;
  final int birthYear;

  Person(this.name, this.birthYear);
}

class DataCache {
  factory DataCache() => instance;
  static final DataCache _instance = DataCache._();

  static DataCache get instance => _instance;

  DataCache._() {
    final random = Random();
    int next(int min, int max) => min + random.nextInt(max - min);
    for (int i = 0; i < 50; i++) {
      var year = next(1990, 2000);
      _persons.add(Person('name_$year', year));
    }
  }

  final List<Person> _persons = [];

  List<Person> get persons => _persons;
}

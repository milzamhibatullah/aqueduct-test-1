import 'package:test1/test1.dart';

class Person extends ManagedObject<_Person> implements _Person {}

class _Person {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;
}

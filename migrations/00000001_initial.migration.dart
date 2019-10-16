import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_Person", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("name", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: true)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final names = [
      'abangjames',
      'jaka',
      'dayat',
      'anis',
      'bambamg',
      'nopal',
      'budi'
    ];
    for (final name in names) {
      await database.store.execute("INSERT INTO _Person (name) VALUES (@name)",
          substitutionValues: {"name": name});
    }
  }
}

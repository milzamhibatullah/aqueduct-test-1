import 'package:aqueduct/aqueduct.dart';
import 'package:test1/model/Person.dart';
import 'package:test1/test1.dart';

class TestController extends ResourceController {
  final ManagedContext context;
  TestController(this.context);

  @Operation.get()
  Future<Response> getAllNames() async {
    final nameQuery = Query<Person>(context)
      ..sortBy((n) => n.id, QuerySortOrder.descending);
    final names = await nameQuery.fetch();
    return Response.ok(names);
  }

  @Operation.get('id')
  Future<Response> getNameById(@Bind.path('id') int id) async {
    final nameQuery = Query<Person>(context)
      ..where((n) => n.id).equalTo(id)
      ..sortBy((n) => n.id, QuerySortOrder.descending);

    final name = await nameQuery.fetchOne();
    if (name == null) {
      return Response.notFound();
    } else {
      return Response.ok(name);
    }
  }

  @Operation.post()
  Future<Response> createPerson() async {
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Person>(context)..values.name = body['name'] as String;
    var _insertedPerson = await query.insert();
    return Response.ok(_insertedPerson);
  }

  @Operation.put()
  Future<Response> updatePerson(@Bind.body() Person pe) async {
    final query = Query<Person>(context)
      ..values.name = pe.name
      ..where((p) => p.id).equalTo(pe.id);
    final _person = await query.update();
    return Response.ok(_person);
  }
}

import 'package:aqueduct/aqueduct.dart';
import 'package:test1/model/Person.dart';
import 'package:test1/test1.dart';

class TestController extends ResourceController {
  final ManagedContext context;
  TestController(this.context);

  @Operation.get()
  Future<Response> getAllNames() async {
    final nameQuery = Query<Person>(context);
    final names = await nameQuery.fetch();
    return Response.ok(names);
  }

  @Operation.get('id')
  Future<Response> getNameById(@Bind.path('id') int id) async {
    final nameQuery = Query<Person>(context)..where((n) => n.id).equalTo(id);

    final name = await nameQuery.fetchOne();
    if (name == null) {
      return Response.notFound();
    } else {
      return Response.ok(name);
    }
  }
}

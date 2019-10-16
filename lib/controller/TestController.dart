import 'package:aqueduct/aqueduct.dart';
import 'package:test1/test1.dart';

class TestController extends Controller {
  final _test = [
    {'id': 1, 'name': 'AbangJames'},
    {'id': 2, 'name': 'Milzam Hibatullah'},
    {'id': 3, 'name': 'Lemon'},
    {'id': 4, 'name': 'Tiger Sugar'},
    {'id': 5, 'name': 'Chaa Time'},
  ];

  @override
  Future<RequestOrResponse> handle(Request request) async {
    return Response.ok(_test);
  }
}

import 'package:aqueduct/managed_auth.dart';

import 'test1.dart';
import 'package:test1/controller/TestController.dart';
import 'package:test1/model/User.dart';
import 'package:test1/controller/RegisterController.dart';

class Test1Channel extends ApplicationChannel {
  ManagedContext context;

  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        'postgres', 'Rahasia_12', 'localhost', 5432, 'names');
    context = ManagedContext(dataModel, persistentStore);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route('/auth/token').link(() => AuthController(authServer));

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router
        .route("/test/[:id]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => TestController(context));

    router
        .route('/register')
        .link(() => RegisterController(context, authServer));
    return router;
  }
}

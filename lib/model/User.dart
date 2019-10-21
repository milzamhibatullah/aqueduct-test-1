import 'package:aqueduct/managed_auth.dart';
import 'package:test1/test1.dart';
import 'package:test1/model/Person.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {}

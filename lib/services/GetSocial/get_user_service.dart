import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';

class GetGetSocialUser {
  Future<String?> getUser(String id) async {
    Map<String, User> user =
        await Communities.getUsers(UserIdList.create([id]));
    // var ano = user['id'] as User;
    return user[id]!.avatarUrl;
  }
}

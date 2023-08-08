import 'dart:async';
import 'dart:developer';

import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';

class CreateIdentity {
  Future<void> updateUserState(var accessToken) async {
    Completer<bool> complete = Completer();
    var user = await getCurrentGetSocialUser();

    var identity = Identity.trusted('relife_userId', accessToken);

    user!.addIdentity(identity, () {
      //print('Successfully logged into ${user.userId} ');
      // log("CreateIdentity  ______ Successfully logged into ${user.userId}");
      complete.complete(true);
    }, (conflict) async {
      // log("CreateIdentity  ______ conflict detected $conflict"); // 678707582080748421
      await GetSocial.switchUser(identity);
      var userNew = await getCurrentGetSocialUser();
      // log("CreateIdentity ______ identity after conflict resolved: ${userNew.toString()} ");
      complete.complete(true);
    },
        (error) => {
              //print('Failed to log into '),
            });

    await complete.future;

    //await Future.delayed(Duration(seconds: 3));

    return;
  }

  Future<void> removeIndentity() async {
    // on log out
    await GetSocial.resetUser();

    // print("get social reset user-- loged out");
  }

  Future<CurrentUser?> getCurrentGetSocialUser() async {
    return await GetSocial.currentUser;
  }
}

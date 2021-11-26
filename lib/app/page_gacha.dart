import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:provider/provider.dart';

import 'page_gacha_sync.dart';
import 'view_account.dart';
import 'view_gacha_log_list.dart';

class PageGacha extends HookWidget {
  static String routeName = "/gacha";

  const PageGacha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var blocAuth = context.watch<BlocAuth>();
    var uid = BlocAuth.watch(context).state.chosenUid();
    var body =
        blocAuth.state.hasLogon() ? ViewGachaLogList(uid: uid) : const Text("");

    return AppBarWithAccount.buildScaffold(context, body, actions: [
      IconButton(
        onPressed: () => PageGachaSync.show(context),
        icon: const Icon(Icons.upload),
      )
    ]);
  }
}

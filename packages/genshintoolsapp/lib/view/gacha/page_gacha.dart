import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/account.dart';

import 'page_gacha_sync.dart';
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

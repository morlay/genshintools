import 'package:genshintoolsapp/common/flutter.dart';
import 'package:webdav/webdav.dart';

class BlocSyncer extends HydratedCubit<WebDAV> {
  static BlocSyncer read(BuildContext buildContext) {
    return buildContext.read<BlocSyncer>();
  }

  static BlocSyncer watch(BuildContext buildContext) {
    return buildContext.watch<BlocSyncer>();
  }

  static const baseRoot = "genshintools";

  BlocSyncer()
      : super(WebDAV(
          root: baseRoot,
          address: "https://dav.jianguoyun.com/dav/",
          username: "",
          password: "",
        ));

  bind(WebDAV webdav) {
    emit(webdav.copyWith(
      root: state.root,
    ));
  }

  @override
  WebDAV? fromJson(Map<String, dynamic> json) {
    return WebDAV.fromJson({
      ...json,
      "root": baseRoot,
    });
  }

  @override
  Map<String, dynamic>? toJson(WebDAV? state) {
    return state?.toJson();
  }
}

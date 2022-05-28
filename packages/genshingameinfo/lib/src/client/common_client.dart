class CommonClient {
  bool useProxy;

  CommonClient({
    this.useProxy = false,
  });

  String mayWithProxy(String p) {
    if (useProxy) {
      return "https://now-proxy-3.vercel.app/${p.replaceAll("://", ":/")}";
    }
    return p;
  }

  Map<String, dynamic> pickDataOrError(Map<String, dynamic> data) {
    if (data.containsKey('message') && (data['retcode'] as int) != 0) {
      throw "[${data["retcode"]}] ${data["message"]}";
    }
    return data['data'];
  }
}

import 'dart:math';

const _proxies = [
  // "https://now-proxy-1.vercel.app",
  // "https://now-proxy-2.vercel.app",
  'https://now-proxy-3.vercel.app',
];

String proxyFor(String url) =>
    '${_proxies[Random().nextInt(_proxies.length)]}/$url';

class Github {
  String repo;
  String branch;

  Github(this.repo, this.branch);

  String rawURL(String path, {bool? nocache}) {
    if (nocache ?? false) {
      return proxyFor(
          'https://github.com/$repo/raw/$branch/${_cleanPath(path)}',);
    }
    return 'https://cdn.jsdelivr.net/gh/$repo@$branch/${_cleanPath(path)}';
  }

  String _cleanPath(String p) {
    if (p.startsWith('/')) {
      return p.substring(1);
    }
    return p;
  }
}

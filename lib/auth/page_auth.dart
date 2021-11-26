import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:genshintools/auth/auth.dart';

class PageAuth extends StatefulWidget {
  const PageAuth({Key? key}) : super(key: key);

  @override
  _PageAuthState createState() => _PageAuthState();
}

class _PageAuthState extends State<PageAuth> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _uid = TextEditingController();
  final TextEditingController _encodedCookie = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _uid.dispose();
    _encodedCookie.dispose();
  }

  Widget build(BuildContext context) {
    var uid = context.watch<AuthCubit>().state.uid;

    if (uid != "") {
      return Scaffold(
        appBar: AppBar(
          title: const Text('当前账户'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(uid),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: const Text('退出登录'),
                  onPressed: () {
                    context.read<AuthCubit>().logout();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "已退出登录",
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('登录'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _uid,
                  decoration: const InputDecoration(
                    labelText: 'UID *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入 UID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _encodedCookie,
                  decoration: const InputDecoration(
                      labelText: 'Base64 Encoded Cookie *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入 Cookie';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                      "Base64 Encoded Cookie 需要访问 https://bbs.mihoyo.com/ys 并登录，在控制台通过运行 btoa(document.cookie) 获得"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    child: const Text('登录'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              Auth(
                                uid: _uid.text,
                                encodedCookie: _encodedCookie.text,
                              ),
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "已登录",
                            ),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

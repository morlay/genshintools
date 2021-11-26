import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

class GSDesc extends HookWidget {
  final I18n desc;

  const GSDesc({
    required this.desc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: Theme.of(context).textTheme.bodyText2,
      ),
      data: desc.text(Lang.CHS).replaceAll("\\n", "\n\n"),
    );
  }
}

class WithLabel extends HookWidget {
  final Widget label;
  final Widget child;

  const WithLabel({
    required this.label,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: DefaultTextStyle.merge(
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1?.let(
                  (it) => it.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: it.color?.withOpacity(0.8),
                  ),
                ),
            child: label,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: child,
        ),
      ],
    );
  }
}

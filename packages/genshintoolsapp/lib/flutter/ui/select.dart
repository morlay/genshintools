import 'package:genshintoolsapp/flutter/flutter.dart';

class SelectState {
  bool selected;
  bool? asOption;

  static SelectState of(BuildContext context) {
    return context.read<SelectState>();
  }

  SelectState({
    required this.selected,
    this.asOption,
  });
}

Widget _defaultBuilder(BuildContext context, List<Widget> children) {
  return FractionallySizedBox(
    heightFactor: 1,
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: children,
          )
        ],
      ),
    ),
  );
}

class Select<T> extends HookWidget {
  final Widget title;
  final List<T> options;
  final T? value;
  final Widget Function(BuildContext context, Selected<T> selected) tileBuilder;
  final Widget Function(BuildContext context, List<Widget> children) builder;
  final Widget Function(
    BuildContext context,
    SelectOption<T> item,
    Selected<T> selected,
  ) optionBuilder;
  final Function(T item)? onSelected;

  const Select({
    required this.title,
    required this.options,
    required this.tileBuilder,
    required this.optionBuilder,
    this.builder = _defaultBuilder,
    this.onSelected,
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tileBuilder(
      context,
      Selected(
        value: value,
        title: title,
        showOptions: showOptions,
      ),
    );
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: DefaultTextStyle.merge(
                  child: title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: builder(context, [
                  ...options.map(
                    (e) => optionBuilder(
                      context,
                      SelectOption(
                        value: e,
                        select: () {
                          onSelected?.let((fn) => fn(e));
                          Navigator.of(context).pop();
                        },
                      ),
                      Selected(
                        value: value,
                        title: title,
                        showOptions: showOptions,
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SelectOption<T> {
  final T value;
  final Function select;

  SelectOption({
    required this.value,
    required this.select,
  });
}

class Selected<T> {
  final T? value;
  final Widget title;
  final Function(BuildContext context) showOptions;

  Selected({
    required this.value,
    required this.title,
    required this.showOptions,
  });
}

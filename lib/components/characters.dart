import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genshintools/genshindb/characters.dart' as characters;
import 'package:genshintools/genshindb/i18n.dart';
import 'package:genshintools/components/commons.dart';

var currentLang = Lang.CHS;

class CharactersContainer extends StatefulWidget {
  const CharactersContainer({Key? key}) : super(key: key);

  @override
  State<CharactersContainer> createState() => _CharactersContainerState();
}

class _CharactersContainerState extends State<CharactersContainer> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: FutureBuilder<characters.CharactersContainer>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/genshindb/characters.json')
              .then((value) => jsonDecode(value))
              .then((data) => characters.CharactersContainer.fromJson(data)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data!.toList();

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (content, i) {
                  return Row(
                    children: [
                      Text("${list[i].id}"),
                      Text(list[i].name.text(currentLang)),
                    ],
                  );
                },
              );
            }

            if (snapshot.hasError) {
              return Text("Ops! ${snapshot.error.toString()}");
            }

            return const Center(
              child: Text("Loading..."),
            );
          }),
    );
  }
}

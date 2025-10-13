import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';

import '../data/constantes.dart';
import '../types/types_containers.dart';
import '../types/types_verbes.dart';

class AfficherVerbe extends StatelessWidget {
  final Verbe verbe;

  const AfficherVerbe({super.key, required this.verbe});

  @override
  Widget build(BuildContext context) {
    List<Widget> toShow = <Widget>[
      VerbBox(verbe: verbe),
    ];

    Widget? ad = context.watch<ProviderAfficherAdBanner>().getAdBanner(context);

    return SafeArea(
        child: Scaffold(
            backgroundColor: couleurBackgroundGeneral,
            appBar: AppBar(
              backgroundColor: couleurAppBar,
              title: const Text("Les verbes irréguliers"),
              centerTitle: true,
              foregroundColor: couleurTexteAppBar,
            ),
            body: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  ...toShow,
                  if (ad != null)
                    SizedBox(
                        height: 70,
                        child: Padding(
                          padding: paddingGeneral,
                          child: ad,
                        ))
                ])));
  }
}

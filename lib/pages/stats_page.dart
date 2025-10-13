import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_containers.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? ad = context.watch<ProviderAfficherAdBanner>().getAdBanner(context);

    return SafeArea(
        child: ListView(shrinkWrap: true, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Titre
          Padding(
            padding: paddingGeneral,
            child: Text(
              "Statistiques",
              style: textStyleMessageFinal,
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
              padding: paddingGeneral,
              child: ContainerClassique(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Les statistiques suivantes concernent uniquement l'onglet \"apprentissage\".",
                    style: textStyleGeneral,
                  ),
                  const Text(""),
                  Text(
                      "Étapes d'apprentissage faites : ${MyUser.stats.etapesApprentissageFaites}",
                      style: textStyleGeneral),
                  Text(
                      "Total de verbes appris : ${MyUser.stats.getTotalVerbesAppris()}",
                      style: textStyleGeneral),
                  Text(
                      "Étapes de révision faites : ${MyUser.stats.etapesRevisionFaites}",
                      style: textStyleGeneral),
                  Text(
                      "Total d'étapes faites : ${MyUser.stats.getTotalEtapesFaites()}",
                      style: textStyleGeneral),
                  const Text(""),
                  Text(
                      "Révisions générales faites : ${MyUser.stats.revisionsGeneralesFaites}",
                      style: textStyleGeneral),
                  const Text(""),
                  Text(
                      "Étapes faites aujourd'hui / limite : ${MyUser.etapesFaitesAjd}/${MyUser.isPremium ? "∞" : limiteEtapesAjd}",
                      style: textStyleGeneral),
                  Text(
                      "Révisions générales faites aujourd'hui / limite : ${MyUser.revisionsQuotidiennesFaitesAjd} / ${MyUser.isPremium ? "∞" : limitesRevQuot}",
                      style: textStyleGeneral)
                ],
              ))),
          if (ad != null)
            SizedBox(
                height: 70,
                child: Padding(
                  padding: paddingGeneral,
                  child: ad,
                ))
        ],
      )
    ]));
  }
}

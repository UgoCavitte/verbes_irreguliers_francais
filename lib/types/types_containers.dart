import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/types/types_textes.dart';
import 'types_verbes.dart';
import '../data/constantes.dart';

class ContainerClassique extends Container {
  ContainerClassique({required Widget child, super.key})
      : super(
            padding: paddingGeneral,
            decoration:
                BoxDecoration(border: Border.all(color: couleurBordure)),
            child: child);
}

class ContainerTitre extends InputDecorator {
  final Widget childWidget;
  final String title;

  ContainerTitre({required this.title, required this.childWidget, super.key})
      : super(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: couleurBordure)),
                label: Text(title, style: textStyleTitledContainer)),
            child: childWidget);

  ContainerTitre.avecBordure(
      {required this.title,
      required Color couleurBordure,
      required this.childWidget,
      super.key})
      : super(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: couleurBordure, width: 1.0)),
                label: Text(title, style: textStyleTitledContainer)),
            child: childWidget);
}

// Le header de la page de présentation des verbes
class CardInfinitif extends Card {
  final Verbe verbe;

  CardInfinitif({required this.verbe, super.key})
      : super(
            shape: const ContinuousRectangleBorder(
                side: BorderSide(color: bleu, width: 3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TexteInfinitif(verbe: verbe))
              ],
            ));
}

class CardConjugaison extends Card {
  final String temps;
  final List<List<String>> conjugaison;

  CardConjugaison({required this.temps, required this.conjugaison, super.key})
      : super(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nom du temps
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: couleurSeparationPronomsFormes))),
              child: TexteNomTemps(
                text: temps,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Personnes
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: paddingTextePronomsEtFormes,
                    child: Column(
                      children: [
                        ...Modele.fromListeDePronomsToListeDeText(
                            (conjugaison[0]
                                .map((p) => Verbe.correctionPersonnes(p))
                                .toList()))
                      ],
                    ),
                  ),
                ),

                // Formes conjuguées
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: paddingTextePronomsEtFormes,
                      child: Container(
                        padding: paddingTextePronomsEtFormes,
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: couleurSeparationPronomsFormes))),
                        child: Column(
                          children: [
                            ...Modele.fromListeDeFormesToListeDeText(
                                conjugaison[1])
                          ],
                        ),
                      )),
                )
              ],
            )
          ],
        ));
}

class VerbBox extends StatelessWidget {
  const VerbBox({required this.verbe, super.key});

  final Verbe verbe;

  @override
  Widget build(BuildContext context) {
    return verbe.createPagePresentation();
  }
}

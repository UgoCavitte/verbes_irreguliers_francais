import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

class PresentationRevision extends StatelessWidget {
  final List<Verbe> verbes;
  final Temps temps;
  final void Function() ajouterTour;

  const PresentationRevision(
      {super.key,
      required this.verbes,
      required this.temps,
      required this.ajouterTour});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextPaddAlign(text: "Bienvenue dans ce module de révision !"),
          TextPaddAlign(
              text:
                  'Durant ce module, vous réviserez les verbes suivants : ${Etape.listeVerbeEtapeString(verbes)}.'),
          TextPaddAlign(
              text: 'Le temps (ou la forme) choisi est : ${temps.nom}'),
          TextPaddAlign(text: 'Appuyez sur "Commencer" pour commencer.'),
          const Spacer(),
          Padding(
            padding: paddingGeneral,
            child: BoutonGros(
                text: stringCommencerBouton, action: () => ajouterTour()),
          )
        ]);
  }
}

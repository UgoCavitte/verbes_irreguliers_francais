import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';
import 'package:verbes_irreguliers_francais/types/types_containers.dart';

import '../../../types/types_temps.dart';
import '../../../types/types_verbes.dart';

class PresentationConjugaison extends Column {
  PresentationConjugaison(
      {super.key,
      required BuildContext context,
      required Verbe verbe,
      required Temps temps,
      required void Function() ajouterTour})
      : super(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextPaddAlign(
                  text:
                      'Voici la conjugaison du verbe "${verbe.infinitif.toLowerCase()}" au ${temps.nom.toLowerCase()} :'),
              Padding(
                  padding: paddingCardConjugaison,
                  child: CardConjugaison(
                      temps: temps.nom,
                      conjugaison: verbe.modele.formes[temps]!)),
              TextPaddAlign(
                  text:
                      'Lisez ces formes plusieurs fois pour essayer de les retenir, puis appuyez sur le bouton "Continuer".'),
              const Spacer(),
              Padding(
                padding: paddingGeneral,
                child: BoutonGros(
                    text: stringContinuerBouton, action: () => ajouterTour()),
              ),
            ]);
}

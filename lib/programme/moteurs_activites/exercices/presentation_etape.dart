import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';

import '../../../data/constantes.dart';
import '../../../types/types_boutons.dart';
import '../../constantes_apprentissages.dart';
import '../../types/etape.dart';
import '../../types/module.dart';

class PresentationEtape extends Column {
  PresentationEtape(
      {super.key,
      required Etape etape,
      required Module module,
      required void Function() ajouterTour})
      : super(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextPaddAlign(
                  text:
                      "Bienvenue dans l'étape ${etape.rang} du module \"${module.description}\" !"),
              TextPaddAlign(
                  text: etape.type == TypeEtape.apprentissage
                      ? 'Durant cette étape d\'apprentissage, vous verrez les verbes suivants : ${Etape.listeVerbeEtapeString(etape.contenu)}.'
                      : 'Durant cette étape de révision, vous passerez en revue les verbes suivants : ${Etape.listeVerbeEtapeString(etape.contenu)}'),
              TextPaddAlign(text: 'Appuyez sur "Commencer" pour commencer.'),
              const Spacer(),
              Padding(
                padding: paddingGeneral,
                child: BoutonGros(
                    text: stringCommencerBouton, action: () => ajouterTour()),
              )
            ]);
}

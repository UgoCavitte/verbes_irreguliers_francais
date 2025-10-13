import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

import '../../../../data/constantes.dart';
import '../../constantes_exos.dart';

class CorrigeGroupeRemplirEntier extends ModeleCorrige {
  final String question;
  final String personne;
  final String bonneReponse;
  final String formeRepondue;

  CorrigeGroupeRemplirEntier(
      {required this.question,
      required this.personne,
      required this.bonneReponse,
      required this.formeRepondue,
      required super.bonOuPas,
      required super.idQst}) {
    // Si l'utilisateur a bien répondu
    if (bonOuPas) {
      super.toShow = Container(
          padding: paddingGeneral,
          margin: paddingGeneral,
          decoration: boxDecorationVerte,
          child: Column(
            children: [
              Text("Question ${idQst + 1}", style: textStyleGeneral),
              Text(question, style: textStyleGeneral),
              Row(
                children: [
                  const Icon(Icons.arrow_forward),
                  Text("Vous avez répondu \"${"$personne $formeRepondue"}\"",
                      style: textStyleGeneral),
                ],
              ),
               Row(
                children: [
                  Icon(Icons.arrow_forward),
                  Text(exosTxtBonneReponse, style: textStyleGeneral),
                ],
              )
            ],
          ));
    }
    // Si l'utilisateur a mal répondu
    else {
      super.toShow = Container(
          padding: paddingGeneral,
          margin: paddingGeneral,
          decoration: boxDecorationRouge,
          child: Column(children: [
            Text("Question ${idQst + 1}", style: textStyleGeneral),
            Text(question, style: textStyleGeneral),
            Row(
              children: [
                const Icon(Icons.arrow_forward),
                Text("Vous avez répondu \"${"$personne $formeRepondue"}\"",
                    style: textStyleGeneral),
              ],
            ),
             Row(
              children: [
                Icon(Icons.arrow_forward),
                Text(exosTxtMauvaiseReponse, style: textStyleGeneral),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.arrow_forward),
                Text("$txtIlFallaitRepondre \"${"$personne $bonneReponse"}\"",
                    style: textStyleGeneral),
              ],
            )
          ]));
    }
  }
}

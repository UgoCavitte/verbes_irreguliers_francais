import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

class CorrigeVerbeVraiFaux extends ModeleCorrige {
  final String question;
  final bool choisiVraiOuFaux; // Ce que l'utilisateur a choisi
  final String bonneReponse;

  CorrigeVerbeVraiFaux(
      {required this.question,
      required this.choisiVraiOuFaux,
      required this.bonneReponse,
      required super.bonOuPas,
      required super.idQst}) {
    // Si la réponse est bonne

    // Il ne faut pas donner la clé parce que la question proposait une bonne variante
    if (super.bonOuPas && choisiVraiOuFaux) {
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
                  Text(
                      "Vous avez répondu \"${choisiVraiOuFaux ? exosTxtVrai : exosTxtFaux}\"",
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

    // Il faut donner la clé parce que la question proposait une mauvaise variante
    else if (super.bonOuPas && !choisiVraiOuFaux) {
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
                  Text(
                      "Vous avez répondu \"${choisiVraiOuFaux ? exosTxtVrai : exosTxtFaux}\"",
                      style: textStyleGeneral),
                ],
              ),
               Row(
                children: [
                  Icon(Icons.arrow_forward),
                  Text(exosTxtBonneReponse, style: textStyleGeneral),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_forward),
                  Text("$txtLaBonneFormeEtait $bonneReponse",
                      style: textStyleGeneral),
                ],
              )
            ],
          ));
    }

    // Si la réponse est mauvaise

    // La forme proposée était correcte, pas besoin de donner de clé
    else if (!bonOuPas && !choisiVraiOuFaux) {
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
                Text(
                    "Vous avez répondu \"${choisiVraiOuFaux ? exosTxtVrai : exosTxtFaux}\"",
                    style: textStyleGeneral),
              ],
            ),
             Row(
              children: [
                Icon(Icons.arrow_forward),
                Text(exosTxtMauvaiseReponse, style: textStyleGeneral),
              ],
            ),
          ]));
    }

    // La forme proposée n'était pas bonne, alors on donne la clé
    else if (!bonOuPas && choisiVraiOuFaux) {
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
              Text(
                  "Vous avez répondu \"${choisiVraiOuFaux ? exosTxtVrai : exosTxtFaux}\"",
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
              Text("$txtLaBonneFormeEtait $bonneReponse",
                  style: textStyleGeneral),
            ],
          )
        ]),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

import '../../../../data/constantes.dart';
import '../../constantes_exos.dart';

class CorrigeTempsTrouveParmi extends ModeleCorrige {
  final String question;
  final String reponseChoisie;
  final String bonneReponse;

  CorrigeTempsTrouveParmi(
      {required this.question,
      required this.reponseChoisie,
      required this.bonneReponse,
      required super.bonOuPas,
      required super.idQst}) {
    super.toShow = Container(
      padding: paddingGeneral,
      margin: paddingGeneral,
      decoration: bonOuPas ? boxDecorationVerte : boxDecorationRouge,
      child: Column(
        children: bonOuPas
            ?
            // Si la réponse est bonne
            [
                Text("Question ${idQst + 1}", style: textStyleGeneral),
                Text(question, style: textStyleGeneral),
                Row(
                  children: [
                    const Icon(Icons.arrow_forward),
                    Text("Vous avez répondu \"$reponseChoisie\"",
                        style: textStyleGeneral),
                  ],
                ),
                 Row(
                  children: [
                    Icon(Icons.arrow_forward),
                    Text(exosTxtBonneReponse, style: textStyleGeneral),
                  ],
                )
              ]
            // La réponse est mauvaise
            : [
                Text("Question ${idQst + 1}", style: textStyleGeneral),
                Text(question, style: textStyleGeneral),
                Row(
                  children: [
                    const Icon(Icons.arrow_forward),
                    Text("Vous avez répondu \"$reponseChoisie\"",
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
                    Text("$txtIlFallaitRepondre $bonneReponse",
                        style: textStyleGeneral),
                  ],
                )
              ],
      ),
    );
  }
}

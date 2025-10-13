import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';

class TitreProgression extends Container {
  TitreProgression({super.key})
      : super(
          padding: paddingTitre,
          color: Colors.white,
          child: Text(
            "${((MyUser.programme.getQtEtapesFaites() / MyUser.programme.getQtEtapes()) * 100).round()} %",
            style: TextStyle(
                fontSize: taillePolice * 1.2, fontWeight: FontWeight.bold, color: bleu),
            textAlign: TextAlign.center,
          ),
        );
}

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';

import '../../data/constantes.dart';

class TitreProgramme extends Container {
  TitreProgramme({super.key})
      : super(
          padding: paddingTitre,
          color: Colors.white,
          child: Text(
            "Programme d'apprentissage",
            style: TextStyle(
                fontSize: taillePolice * 1.2, fontWeight: FontWeight.bold, color: bleu),
            textAlign: TextAlign.center,
          ),
        );
}

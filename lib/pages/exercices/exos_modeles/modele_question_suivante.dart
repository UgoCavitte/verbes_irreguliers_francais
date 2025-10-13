import 'package:flutter/material.dart';

import '../../../data/constantes.dart';
import '../../../types/types_boutons.dart';
import '../constantes_exos.dart';

class ModeleQuestionSuivante extends Container {
  final bool bon;
  final Function onChanged;

  ModeleQuestionSuivante(
      {required this.bon, required this.onChanged, super.key})
      : super(
          padding: paddingGeneral,
          color: bon ? Colors.green : Colors.red,
          child: Column(
            children: [
              Padding(
                  padding: paddingGeneral,
                  child: Text(
                    bon ? exosTxtBonneReponse : exosTxtMauvaiseReponse,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              BoutonGros(text: exosTxtSuivant, action: () => onChanged())
            ],
          ),
        );
}

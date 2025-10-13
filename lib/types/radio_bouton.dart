import 'package:flutter/material.dart';

import '../data/constantes.dart';

class RadioBouton extends RadioListTile {
  final Text titre;
  final dynamic valeur;
  final dynamic groupeValeur;
  final ValueChanged<dynamic>? onChangedFonction;

  const RadioBouton(
      this.titre, this.valeur, this.groupeValeur, this.onChangedFonction,
      {super.key})
      : super(
          title: titre,
          value: valeur,
          groupValue: groupeValeur,
          onChanged: onChangedFonction,
          activeColor: rouge,
        );
}

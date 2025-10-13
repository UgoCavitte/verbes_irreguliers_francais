import 'package:flutter/material.dart';
import '../data/constantes.dart';
import 'types_verbes.dart';

class TexteNomTemps extends Text {
  final String text;

  TexteNomTemps({required this.text, super.key})
      : super(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: taillePolice,
                fontWeight: FontWeight.bold, color: couleurTexteBasique));
}



class TexteConjugaison extends Text {
  final String text;

  TexteConjugaison({required this.text, super.key})
      : super(text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: taillePolice, color: couleurTexteBasique));
}

class TexteInfinitif extends Text {
  final Verbe verbe;

  TexteInfinitif({required this.verbe, super.key})
      : super(
            "${verbe.infinitif.toUpperCase()} (sous-groupe : ${verbe.sousGroupe.nom})",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: taillePolice,
                fontWeight: FontWeight.bold, color: couleurTexteBasique));
}

class TexteInfinitifBouton extends Text {
  final String text;

  TexteInfinitifBouton({required this.text, super.key})
      : super(text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: taillePolice, color: Colors.white));
}

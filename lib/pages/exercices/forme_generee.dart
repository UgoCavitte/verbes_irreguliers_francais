import 'dart:math';

import 'package:verbes_irreguliers_francais/data/temps.dart';

import '../../types/types_temps.dart';
import '../../types/types_verbes.dart';
import 'constantes_exos.dart';

class FormeGeneree {
  String personne = "default";
  String forme = "default";
  Temps temps = TempsPresent();

  FormeGeneree(
      {required List<Temps> tempsPossibles,
      required Verbe verbe,
      required List<String> dejaGenere}) {
    Random rng = Random();

    int attempts = 0;
    bool continuer = true;
    while (continuer) {
      // Choisit un nombre entier en fonction du nombre de temps proposés
      // On évite de générer un nombre random si un seul temps est proposé
      temps = tempsPossibles.length == 1
          ? tempsPossibles[0]
          : tempsPossibles[rng.nextInt(tempsPossibles.length)];

      // On sort les formes de la map pour alléger le code
      List<List<String>> formesAuTempsChoisi = verbe.modele.formes[temps]!;
      // Puis on choisit une forme random
      int iDPersonne = formesAuTempsChoisi[0].length == 1
          ? 0
          : rng.nextInt(formesAuTempsChoisi[0].length);
      personne = formesAuTempsChoisi[0][iDPersonne];
      forme = formesAuTempsChoisi[1][iDPersonne];

      // La forme est dans la liste
      if (dejaGenere.contains(forme) &&
          attempts < gnrExoNbrTentativesAvantEchec) {
        continuer = true;
        attempts++;
      } else {
        attempts = 0;
        continuer = false;
      }
    }
  }
}

/*
 * Cette classe permet de suivre l'apprentissage de chaque temps pour chaque
 * verbe
 * Elle contient le nom du temps verbal et le niveau d'apprentissage
 * Les formes du verbes sont dans l'autre partie de la Map
 */

import 'dart:math';

import '../data/temps.dart';
import 'types_verbes.dart';

class Temps {
  static const int tempsCommenceParConsonne = 0;
  static const int tempsCommenceParVoyelle = 1;
  static const int tempsTypeParticipe = 2;

  String nom = "default";

  // Cette liste s'initialise au lancement de l'application
  List<Verbe> verbeIrreguliersACeTemps = [];

  // Renvoie un verbe random de la liste des verbes irréguliers à ce temps
  Verbe verbeRandom({required Random random}) {
    return verbeIrreguliersACeTemps[
        random.nextInt(verbeIrreguliersACeTemps.length)];
  }

  // Temps from String
  static Temps tempsFromNom(String nom) {
    for (Temps temps in listeTemps) {
      if (temps.nom == nom) {
        return temps;
      }
    }
    throw "Erreur de lecture d'un temps";
  }

  @override
  bool operator ==(Object other) => other is Temps && other.nom == nom;

  @override
  int get hashCode => nom.hashCode;

  // Renvoie si le nom du temps commence par une voyelle, une consonne ou bien
  // s'il s'agit d'un participe
  int typeDeTemps() {
    // Si le temps commence par une consonne
    if ([nomPresent, nomFuturSimple, nomSubjonctif].contains(nom)) {
      return tempsCommenceParConsonne;
    }
    // Si le temps commence par une voyelle
    else if ([nomImparfait, nomImperatif].contains(nom)) {
      return tempsCommenceParVoyelle;
    }
    // Participes
    else {
      return tempsTypeParticipe;
    }
  }
}

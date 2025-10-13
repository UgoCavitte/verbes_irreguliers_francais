import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/verbes/corrige_verbe_remplir_entier.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_exo_remplir_entier.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/forme_generee.dart';

import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';

class VerbesRemplirEntier {
  final int quantite;
  final Verbe verbe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  VerbesRemplirEntier(
      {required this.quantite,
      required this.verbe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionRemplirEntierVerbe> questions = genererQuestions();

    for (int i = 0; i < questions.length; i++) {
      questionsPretes.add(ModeleExoRemplirEntier(
          question: questions[i].phrase,
          personne: questions[i].personne,
          reponse: questions[i].forme,
          onChanged: (paireBoolString) => onChanged(CorrigeVerbeRemplirEntier(
              question: questions[i].phrase,
              personne: questions[i].personne,
              bonneReponse: questions[i].forme,
              formeRepondue: paireBoolString.forme,
              bonOuPas: paireBoolString.bonOuPas,
              idQst: i + nbrQstDejaFaites))));
    }
  }

  // Génère les questions

  /*
   * 1. Générer une forme générée
   * 2. Ajouter le tout à la liste
   */

  List<QuestionRemplirEntierVerbe> genererQuestions() {
    List<QuestionRemplirEntierVerbe> questions = [];
    List<String> formesUtilisees = [];

    // Génère une quantité définie de questions
    for (int i = 0; i < quantite; i++) {
      // Génère une forme aléatoire
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: temps, verbe: verbe, dejaGenere: formesUtilisees);

      // Ajoute la forme générée à la liste des formes déjà utilisées
      formesUtilisees.add(formeGeneree.forme);

      // Crée la question et l'ajoute à la liste des question prêtes
      questions.add(QuestionRemplirEntierVerbe(
          personne: formeGeneree.personne,
          forme: formeGeneree.forme,
          temps: formeGeneree.temps,
          verbe: verbe));
    }

    return questions;
  }
}

class QuestionRemplirEntierVerbe {
  final String personne;
  final String forme;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionRemplirEntierVerbe(
      {required this.personne,
      required this.forme,
      required this.temps,
      required this.verbe}) {
    int typeDeTemps = temps.typeDeTemps();
    // Temps dont le nom commence par une consonne
    if (typeDeTemps == Temps.tempsCommenceParConsonne) {
      phrase = "\"${verbe.infinitif}\" au ${temps.nom.toLowerCase()}";
    }

    // Impératif
    else if (temps.nom == nomImperatif) {
      phrase =
          "${Verbe.numeroPersonneToTexte(personne)} de \"${verbe.infinitif.toLowerCase()}\" à l'impératif";
    }
    // Temps dont le nom commence par une voyelle
    else if (typeDeTemps == Temps.tempsCommenceParVoyelle) {
      phrase = "\"${verbe.infinitif}\" à l'${temps.nom.toLowerCase()}";
    }
    // Participes
    else {
      phrase = "${temps.nom} de \"${verbe.infinitif.toLowerCase()}\"";
    }
  }
}

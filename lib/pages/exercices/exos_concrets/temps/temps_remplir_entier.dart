import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/temps/corrige_temps_remplir_entier.dart';
import '../../exos_modeles/modele_exo_remplir_entier.dart';
import '../../forme_generee.dart';

class TempsRemplirEntier {
  final int quantite;
  final Temps temps;
  final int nbrQstDejaFaites;
  final ValueChanged<CorrigeTempsRemplirEntier> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  TempsRemplirEntier(
      {required this.quantite,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionRemplirEntierTemps> questions = genererQuestions();

    for (int i = 0; i < questions.length; i++) {
      questionsPretes.add(ModeleExoRemplirEntier(
          question: questions[i].phrase,
          personne: questions[i].personne,
          reponse: questions[i].forme,
          onChanged: (paireBoolString) => onChanged(CorrigeTempsRemplirEntier(
              question: questions[i].phrase,
              personne: questions[i].personne,
              bonneReponse: questions[i].forme,
              formeRepondue: paireBoolString.forme,
              bonOuPas: paireBoolString.bonOuPas,
              idQst: i + nbrQstDejaFaites))));
    }
  }

  // Génère les questions
  List<QuestionRemplirEntierTemps> genererQuestions() {
    List<QuestionRemplirEntierTemps> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Un tour par question
    for (int i = 0; i < quantite; i++) {
      // Choisit un verbe irrégulier à ce temps
      Verbe verbeChoisi = temps.verbeRandom(random: rng);

      // Génère une forme aléatoire
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: [temps],
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);

      // Ajoute la forme générée à la liste des formes déjà utilisées
      formesUtilisees.add(formeGeneree.forme);

      // Crée la question et l'ajoute à la liste des question prêtes
      questions.add(QuestionRemplirEntierTemps(
          personne: formeGeneree.personne,
          forme: formeGeneree.forme,
          temps: formeGeneree.temps,
          verbe: verbeChoisi));
    }

    return questions;
  }
}

class QuestionRemplirEntierTemps {
  final String personne;
  final String forme;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionRemplirEntierTemps(
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

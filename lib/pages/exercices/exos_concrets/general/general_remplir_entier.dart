import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/verbes/corrige_verbe_remplir_entier.dart';
import '../../exos_modeles/modele_exo_remplir_entier.dart';
import '../../forme_generee.dart';

class GeneralRemplirEntier {
  final int quantite;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GeneralRemplirEntier(
      {required this.quantite,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionRemplirEntierGeneral> questions = genererQuestions();

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

  List<QuestionRemplirEntierGeneral> genererQuestions() {
    List<QuestionRemplirEntierGeneral> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Choisit un verbe au hasard
    Verbe verbeChoisi = listeVerbes[rng.nextInt(listeVerbes.length)];

    // Génère une quantité définie de questions
    for (int i = 0; i < quantite; i++) {
      // Génère une forme aléatoire
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: verbeChoisi.getTempsPossibles(),
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);

      // Ajoute la forme générée à la liste des formes déjà utilisées
      formesUtilisees.add(formeGeneree.forme);

      // Crée la question et l'ajoute à la liste des question prêtes
      questions.add(QuestionRemplirEntierGeneral(
          personne: formeGeneree.personne,
          forme: formeGeneree.forme,
          temps: formeGeneree.temps,
          verbe: verbeChoisi));
    }

    return questions;
  }
}

class QuestionRemplirEntierGeneral {
  final String personne;
  final String forme;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionRemplirEntierGeneral(
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

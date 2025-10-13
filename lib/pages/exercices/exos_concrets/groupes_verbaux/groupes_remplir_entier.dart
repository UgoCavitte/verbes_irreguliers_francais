import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/groupes_verbaux/corrige_groupe_remplir_entier.dart';
import '../../exos_modeles/modele_exo_remplir_entier.dart';
import '../../forme_generee.dart';

class GroupesRemplirEntier {
  final int quantite;
  final SousGroupe sousGroupe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GroupesRemplirEntier(
      {required this.quantite,
      required this.sousGroupe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionRemplirEntierGroupe> questions = genererQuestions();

    for (int i = 0; i < questions.length; i++) {
      questionsPretes.add(ModeleExoRemplirEntier(
          question: questions[i].phrase,
          personne: questions[i].personne,
          reponse: questions[i].forme,
          onChanged: (paireBoolString) => onChanged(CorrigeGroupeRemplirEntier(
              question: questions[i].phrase,
              personne: questions[i].personne,
              bonneReponse: questions[i].forme,
              formeRepondue: paireBoolString.forme,
              bonOuPas: paireBoolString.bonOuPas,
              idQst: i + nbrQstDejaFaites))));
    }
  }

  List<QuestionRemplirEntierGroupe> genererQuestions() {
    List<QuestionRemplirEntierGroupe> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    for (int i = 0; i < quantite; i++) {
      // Étape 1 -> choisir un verbe dans le groupe
      Verbe verbeChoisi = sousGroupe.verbeRandom(random: rng);

      // Génère une forme aléatoire
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: temps,
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);

      // Ajoute la forme générée à la liste des formes déjà utilisées
      formesUtilisees.add(formeGeneree.forme);

      // Ajoute la question
      questions.add(QuestionRemplirEntierGroupe(
          personne: formeGeneree.personne,
          forme: formeGeneree.forme,
          temps: formeGeneree.temps,
          verbe: verbeChoisi));
    }

    return questions;
  }
}

class QuestionRemplirEntierGroupe {
  final String personne;
  final String forme;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionRemplirEntierGroupe(
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

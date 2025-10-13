import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/question_apprentissage_revision.dart';

import '../../../data/temps.dart';
import '../../../types/types_temps.dart';
import '../../../types/types_verbes.dart';

/*
 * Cet exercice présente une liste de questions à l'utilisateur
 * 
 * Les questions comportent obligatoirement toutes les personnes du verbe en
 * cours
 * Si le verbe en cours n'est pas le premier de l'étape, alors les questions
 * contiennent obligatoirement des questions sur moitié moins de formes
 * 
 * Si l'utilisateur répond incorrectement à une question, l'exercice lui
 * présente la bonne réponse et la question est reposée à la fin de l'exercice
 * 
 * L'exercice ne se termine que lorsque l'utilisateur est parvenu à répondre
 * correctement à toutes les questions
 */

abstract class QuestionsMoteur {
  static List<QuestionApprentissageRevision> getQuestions(
      {
      /* 
   * Cette variable est une liste parce que l'exercice est utilisé à la fois par
   * les étapes d'apprentissage et  de révision.
   * 
   * Lors d'une étape d'apprentissage, la liste ne contient qu'un seul élément
   * Lors d'une étape de révision, elle contient tous les verbes de l'étape
   */
      required List<Verbe> verbeEnCours,
      required List<Verbe> verbeDejaFaits,
      required Temps temps,
      required TypeEtape typeEtape,
      // Grosse étape de révision ?
      required bool grosseEtape,
      required void Function(bool) questionSuivante}) {
    // Liste des questions
    List<TypeQuestion> listeQuestions = [];

    // Création des questions
    // D'abord pour le verbe en cours
    // Cas pour l'apprentissage
    if (verbeEnCours.length == 1) {
      List<List<String>> formes = verbeEnCours[0].modele.formes[temps]!;

      for (int i = 0; i < formes[0].length; i++) {
        listeQuestions.add(TypeQuestion(
            personne: formes[0][i],
            forme: formes[1][i],
            verbe: verbeEnCours[0],
            temps: temps));
      }
    }

    // Cas pour les révisions
    else {
      Random random = Random();

      for (var verbe in verbeEnCours) {
        List<List<String>> formes = verbe.modele.formes[temps]!;

        // Liste des index des personnes faites
        List<int> personnesFaites = [];

        // Variable temporaire
        int index = 0;

        for (int i = 0; i < (formes[0].length > 4 ? 4 : 1); i++) {
          // Génération de l'index de la personne
          do {
            index = random.nextInt(formes[0].length);
          } while (personnesFaites.contains(index));

          listeQuestions.add(TypeQuestion(
              personne: formes[0][index],
              forme: formes[1][index],
              verbe: verbe,
              temps: temps));
        }
      }
    }

    // Puis pour les verbes déjà faits
    if (verbeDejaFaits.isNotEmpty) {
      Random random = Random();
      int limiteBoucleFormes = (listeQuestions.length / 2).round();

      for (var verbe in verbeDejaFaits) {
        List<List<String>> formes = verbe.modele.formes[temps]!;

        // Liste des index des personnes faites
        List<int> personnesFaites = [];

        // Variable temporaire
        int index = 0;

        for (int i = 0; i <= limiteBoucleFormes; i++) {
          // Génération de l'index de la personne
          do {
            index = random.nextInt(formes[0].length);
          } while (personnesFaites.contains(index));

          listeQuestions.add(TypeQuestion(
              personne: formes[0][index],
              forme: formes[1][index],
              verbe: verbe,
              temps: temps));
        }
      }
    }

    // Puis on mélange
    listeQuestions.shuffle();

    // CREATION DES WIDGETS
    List<QuestionApprentissageRevision> listeWidgets = [];

    for (var qst in listeQuestions) {
      listeWidgets.add(QuestionApprentissageRevision(
          key: UniqueKey(),
          phrase: qst.phrase,
          personne: qst.personne,
          bonneReponse: qst.forme,
          typeEtape: typeEtape,
          questionSuivanteOnChange: questionSuivante));
    }

    return listeWidgets;
  }
}

class TypeQuestion {
  final String personne;
  final String forme;
  final Verbe verbe;
  final Temps temps;
  late String phrase;

  TypeQuestion(
      {required this.personne,
      required this.forme,
      required this.verbe,
      required this.temps}) {
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

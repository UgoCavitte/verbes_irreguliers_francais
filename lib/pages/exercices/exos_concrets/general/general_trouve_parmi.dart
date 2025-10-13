import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/verbes/corrige_verbe_trouve_parmi.dart';
import '../../exos_modeles/modele_trouve_parmi.dart';
import '../../forme_generee.dart';

class GeneralTrouveParmi {
  final int quantite;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GeneralTrouveParmi(
      {required this.quantite,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionTrouveParmiGeneral> questions = genererQuestions();

    for (int i = 0; i < questions.length; i++) {
      String formeCorrecte =
          "${Verbe.correctionPersonnes(questions[i].personne)} ${questions[i].bonneForme}";

      questionsPretes.add(ModeleTrouveParmi(
          question: questions[i].phrase,
          bonneReponse: formeCorrecte,
          mauvaisesReponses: questions[i]
              .faussesFormes
              .map((f) =>
                  "${Verbe.correctionPersonnes(questions[i].personne)} $f")
              .toList(),
          onChanged: (reponseChoisie) {
            onChanged(CorrigeVerbeTrouveParmi(
                question: questions[i].phrase,
                reponseChoisie: reponseChoisie,
                bonneReponse: formeCorrecte,
                bonOuPas: reponseChoisie == formeCorrecte ? true : false,
                idQst: i + nbrQstDejaFaites));
          }));
    }
  }

  List<QuestionTrouveParmiGeneral> genererQuestions() {
    List<QuestionTrouveParmiGeneral> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Un tour par question
    for (int i = 0; i < quantite; i++) {
      // Choisit un verbe au hasard
      Verbe verbeChoisi = listeVerbes[rng.nextInt(listeVerbes.length)];

      // Génère une bonne forme
      FormeGeneree bonneFormeGeneree = FormeGeneree(
          tempsPossibles: verbeChoisi.getTempsPossibles(),
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);
      // L'ajoute à la liste des formes utilisées
      formesUtilisees.add(bonneFormeGeneree.forme);

      // Génère des fausses formes
      List<FormeGeneree> faussesFormes = [];
      for (int j = 0; j < 3; j++) {
        faussesFormes.add(FormeGeneree(
            tempsPossibles: verbeChoisi.getTempsPossibles(),
            verbe: verbeChoisi,
            dejaGenere: [
              ...faussesFormes.map((g) => g.forme),
              bonneFormeGeneree.forme
            ]));
      }

      // Ajoute le tout à la liste de questions à retourner
      questions.add(QuestionTrouveParmiGeneral(
          personne: bonneFormeGeneree.personne,
          bonneForme: bonneFormeGeneree.forme,
          faussesFormes: faussesFormes.map((a) => a.forme).toList(),
          temps: bonneFormeGeneree.temps,
          verbe: verbeChoisi));
    }

    return questions;
  }
}

class QuestionTrouveParmiGeneral {
  final String personne;
  final String bonneForme;
  final List<String> faussesFormes;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionTrouveParmiGeneral(
      {required this.personne,
      required this.bonneForme,
      required this.faussesFormes,
      required this.temps,
      required this.verbe}) {
    int typeDeTemps = temps.typeDeTemps();
    // Si c'est un participe
    if (typeDeTemps == Temps.tempsTypeParticipe) {
      phrase =
          "Le ${temps.nom.toLowerCase()} de \"${verbe.infinitif.toLowerCase()}\" est :";
    }

    // Impératif
    else if (temps.nom == nomImperatif) {
      phrase =
          "Quelle forme de \"${Verbe.numeroPersonneToTexte(personne).toLowerCase()}\" est correcte à l'impératif ?";
    }

    // Si le temps commence par une consonne
    else if (typeDeTemps == Temps.tempsCommenceParConsonne) {
      phrase =
          "Quelle forme de \"${verbe.infinitif.toLowerCase()}\" est correcte au ${temps.nom.toLowerCase()} ?";
    }

    // Si le temps commence par une voyelle
    else {
      phrase =
          "Quelle forme de \"${verbe.infinitif.toLowerCase()}\" est correcte à l'${temps.nom.toLowerCase()} ?";
    }
  }
}

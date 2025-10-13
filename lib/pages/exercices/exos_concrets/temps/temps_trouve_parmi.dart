import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_trouve_parmi.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/temps/corrige_temps_trouve_parmi.dart';
import '../../forme_generee.dart';

class TempsTrouveParmi {
  final int quantite;
  final Temps temps;
  final int nbrQstDejaFaites;
  final ValueChanged<CorrigeTempsTrouveParmi> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  TempsTrouveParmi(
      {required this.quantite,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionTrouveParmiTemps> questions = genererQuestions();

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
            onChanged(CorrigeTempsTrouveParmi(
                question: questions[i].phrase,
                reponseChoisie: reponseChoisie,
                bonneReponse: formeCorrecte,
                bonOuPas: reponseChoisie == formeCorrecte ? true : false,
                idQst: i + nbrQstDejaFaites));
          }));
    }
  }

  // Génère les questions
  List<QuestionTrouveParmiTemps> genererQuestions() {
    List<QuestionTrouveParmiTemps> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Génère le nombre de questions voulu
    for (int i = 0; i < quantite; i++) {
      // Choisit un verbe parmi les verbes irrégulier à ce temps
      Verbe verbeChoisi = temps.verbeIrreguliersACeTemps[
          rng.nextInt(temps.verbeIrreguliersACeTemps.length)];

      // Génère une bonne forme
      FormeGeneree bonneFormeGeneree = FormeGeneree(
          tempsPossibles: [temps],
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
      // Ajoute le tout à la liste de questions
      questions.add(QuestionTrouveParmiTemps(
          personne: bonneFormeGeneree.personne,
          bonneForme: bonneFormeGeneree.forme,
          faussesFormes: faussesFormes.map((f) => f.forme).toList(),
          temps: temps,
          verbe: verbeChoisi));
    }

    return questions;
  }
}

class QuestionTrouveParmiTemps {
  final String personne;
  final String bonneForme;
  final List<String> faussesFormes;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionTrouveParmiTemps(
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

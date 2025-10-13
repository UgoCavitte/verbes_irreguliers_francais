import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../exos_corriges/groupes_verbaux/corrige_groupe_trouve_parmi.dart';
import '../../exos_modeles/modele_trouve_parmi.dart';
import '../../forme_generee.dart';

class GroupesTrouveParmi {
  final int quantite;
  final SousGroupe sousGroupe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<CorrigeGroupeTrouveParmi> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GroupesTrouveParmi(
      {required this.quantite,
      required this.sousGroupe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionTrouveParmiGroupe> questions = genererQuestions();

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
            onChanged(CorrigeGroupeTrouveParmi(
                question: questions[i].phrase,
                reponseChoisie: reponseChoisie,
                bonneReponse: formeCorrecte,
                bonOuPas: reponseChoisie == formeCorrecte ? true : false,
                idQst: i + nbrQstDejaFaites));
          }));
    }
  }

  List<QuestionTrouveParmiGroupe> genererQuestions() {
    List<QuestionTrouveParmiGroupe> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Génère une quantité définie de questions
    for (int i = 0; i < quantite; i++) {
      // Étape 1 -> choisir un verbe
      Verbe verbeChoisi = sousGroupe.verbeRandom(random: rng);

      // Génère une bonne forme
      FormeGeneree bonneFormeGeneree = FormeGeneree(
          tempsPossibles: temps,
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
      questions.add(QuestionTrouveParmiGroupe(
          personne: bonneFormeGeneree.personne,
          bonneForme: bonneFormeGeneree.forme,
          faussesFormes: faussesFormes.map((a) => a.forme).toList(),
          temps: bonneFormeGeneree.temps,
          verbe: verbeChoisi));
    }
    return questions;
  }
}

class QuestionTrouveParmiGroupe {
  final String personne;
  final String bonneForme;
  final List<String> faussesFormes;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionTrouveParmiGroupe(
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

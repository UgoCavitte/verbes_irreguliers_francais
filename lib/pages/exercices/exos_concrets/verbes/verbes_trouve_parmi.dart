import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/verbes/corrige_verbe_trouve_parmi.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_trouve_parmi.dart';

import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../forme_generee.dart';

/*
 * L'utilisateur doit trouver la bonne forme parmi quatre proposées
 * Les fausses formes gardent la même personne
 * La question indique le temps
 */

class VerbesTrouveParmi {
  final int quantite;
  final Verbe verbe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<CorrigeVerbeTrouveParmi> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  VerbesTrouveParmi(
      {required this.quantite,
      required this.verbe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionTrouveParmiVerbe> questions = genererQuestions();

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

  List<QuestionTrouveParmiVerbe> genererQuestions() {
    List<QuestionTrouveParmiVerbe> questions = [];
    List<String> formesUtilisees = [];

    // Génère une quantité définie de questions
    for (int i = 0; i < quantite; i++) {
      // Génère une bonne forme
      FormeGeneree bonneFormeGeneree = FormeGeneree(
          tempsPossibles: temps, verbe: verbe, dejaGenere: formesUtilisees);
      // L'ajoute à la liste des formes utilisées
      formesUtilisees.add(bonneFormeGeneree.forme);

      // Génère des fausses formes
      List<FormeGeneree> faussesFormes = [];
      for (int j = 0; j < 3; j++) {
        faussesFormes.add(FormeGeneree(
            tempsPossibles: verbe.getTempsPossibles(),
            verbe: verbe,
            dejaGenere: [
              ...faussesFormes.map((g) => g.forme),
              bonneFormeGeneree.forme
            ]));
      }

      // Ajoute le tout à la liste de questions à renvoyer
      questions.add(QuestionTrouveParmiVerbe(
          personne: bonneFormeGeneree.personne,
          bonneForme: bonneFormeGeneree.forme,
          faussesFormes: faussesFormes.map((a) => a.forme).toList(),
          temps: bonneFormeGeneree.temps,
          verbe: verbe));
    }

    return questions;
  }
}

class QuestionTrouveParmiVerbe {
  final String personne;
  final String bonneForme;
  final List<String> faussesFormes;
  final Temps temps;
  final Verbe verbe;
  String phrase = "";

  QuestionTrouveParmiVerbe(
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

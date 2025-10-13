import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/temps/corrige_temps_vrai_faux.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_exo_vrai_faux.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/forme_generee.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';

class TempsVraiFaux {
  final int quantite;
  final Temps temps;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  TempsVraiFaux(
      {required this.quantite,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionVraiFauxTemps> questions = genererQuestions();

    // Créer une page selon "modele exo vrai faux" pour chaque question
    for (int i = 0; i < quantite; i++) {
      questionsPretes.add(ModeleExoVraiFaux(
          vrai: questions[i].reponse,
          question: questions[i].phrase,
          onChanged: (bonBool) => onChanged(CorrigeTempsVraiFaux(
              question: questions[i].phrase,
              choisiVraiOuFaux:
                  bonBool ? questions[i].reponse : !questions[i].reponse,
              bonneReponse: questions[i].bonneFormeSiFaux,
              bonTempsSiFaux: questions[i].bonTempsSiFaux,
              bonOuPas: bonBool,
              idQst: i + nbrQstDejaFaites))));
    }
  }

  // Génère les questions

  /*
   * 1. Sélectionner un verbe parmi les verbes irréguliers au temps sélectionné
   * 2. Générer une forme de ce verbe au temps voulu
   * 3. Générer un nombre random qui permette de définir s'il faut que la
   *    réponse soit vraie ou fausse
   * 4.a. Si la réponse est vraie, ajouter à la liste
   * 4.b. Si la réponse est fausse, générer une autre forme
   *      "Faux" signifie que le temps ne correspondent pas à la forme (la
   *      personne reste la même)
   *      Ajouter à la liste
   */

  List<QuestionVraiFauxTemps> genererQuestions() {
    List<QuestionVraiFauxTemps> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Fait un tour pour chaque question
    for (int i = 0; i < quantite; i++) {
      // Étape 1 : choisi un verbe
      Verbe verbeChoisi = temps.verbeRandom(random: rng);

      // Étape 2
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: [temps],
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);

      formesUtilisees.add(formeGeneree.forme);

      // Étapes 3 et 4
      // 4.a
      if (rng.nextBool()) {
        questions.add(QuestionVraiFauxTemps(
            personne: formeGeneree.personne,
            forme: formeGeneree.forme,
            temps: temps,
            verbe: verbeChoisi,
            reponse: true,
            bonneFormeSiFaux: formeGeneree.forme,
            bonTempsSiFaux: temps));
      }

      // 4.b
      else {
        // Choisis le temps random duquel prendre la fausse forme
        // On vérifie d'abord que le verbe est irrégulier à d'autres temps
        late Temps fauxTemps;
        if (verbeChoisi.getTempsPossibles().length > 1) {
          do {
            fauxTemps = verbeChoisi.getTempsPossibles()[
                rng.nextInt(verbeChoisi.getTempsPossibles().length)];
          } while (fauxTemps == temps);
        }

        // Si le verbe n'est irrégulier qu'à un temps
        else {
          fauxTemps = verbeChoisi.getTempsPossibles()[
              rng.nextInt(verbeChoisi.getTempsPossibles().length)];
        }

        String fausseForme = "";
        // On vérifie le nombre de personnes pour ce temps pour ce verbe
        if (verbeChoisi.modele.formes[temps]![0].length ==
            verbeChoisi.modele.formes[fauxTemps]![0].length) {
          // Si c'est égal, alors on peut prendre la même personne pour rendre l'exo plus intéressant

          int indexPersonne = verbeChoisi.modele.formes[temps]![0]
              .indexOf(formeGeneree.personne);
          fausseForme = verbeChoisi.modele.formes[fauxTemps]![1][indexPersonne];
        } else {
          // Si le nombre de personne diffère, alors on prend simplement une forme random disponible au faux temps
          int max = verbeChoisi.modele.formes[fauxTemps]![0].length;
          fausseForme =
              verbeChoisi.modele.formes[fauxTemps]![1][rng.nextInt(max)];
        }

        // Il faut vérifier que la bonne forme diffère de la fausse
        // Si c'est le cas, la réponse est "faux"
        if (formeGeneree.forme != fausseForme) {
          questions.add(QuestionVraiFauxTemps(
              personne: formeGeneree.personne,
              forme: fausseForme,
              temps: temps,
              verbe: verbeChoisi,
              reponse: false,
              bonneFormeSiFaux: formeGeneree.forme,
              bonTempsSiFaux: fauxTemps));
        }

        // Sinon, on rend la réponse vraie
        else {
          questions.add(QuestionVraiFauxTemps(
              personne: formeGeneree.personne,
              forme: formeGeneree.forme,
              temps: temps,
              verbe: verbeChoisi,
              reponse: true,
              bonneFormeSiFaux: formeGeneree.forme,
              bonTempsSiFaux: temps));
        }
      }
    }

    return questions;
  }
}

class QuestionVraiFauxTemps {
  final String personne;
  final String forme;
  final Temps temps;
  final Verbe verbe;
  final bool reponse;
  final String bonneFormeSiFaux; // Forme au temps indiqué
  final Temps bonTempsSiFaux; // Temps de la fausse forme

  String phrase = "";

  QuestionVraiFauxTemps(
      {required this.personne,
      required this.forme,
      required this.temps,
      required this.verbe,
      required this.reponse,
      required this.bonneFormeSiFaux,
      required this.bonTempsSiFaux}) {
    // Participe passé
    if (temps.nom == nomParticipePasse) {
      phrase =
          "Le participe passé de \"${verbe.infinitif.toLowerCase()}\" est \"$forme\" ?";
    }

    // Participe présent
    else if (temps.nom == nomParticipePresent) {
      phrase =
          "Le participe présent de \"${verbe.infinitif.toLowerCase()}\" est \"$forme\" ?";
    }

    // Impératif
    else if (temps.nom == nomImperatif) {
      switch (personne) {}
      phrase =
          "${Verbe.numeroPersonneToTexte(personne)} de \"${verbe.infinitif.toLowerCase()}\" à l'impératif est \"$forme\" ?";
    }

    // Reste
    else {
      // Si la personne s'élide (càd "j'")
      if (personne == "J'") {
        // Si le temps commence par une consonne
        if (temps.typeDeTemps() == Temps.tempsCommenceParConsonne) {
          phrase =
              "\"$personne$forme\" est correct au ${temps.nom.toLowerCase()} ?";
        }

        // Si le temps commence par une voyelle
        else {
          phrase =
              "\"$personne$forme\" est correct à l'${temps.nom.toLowerCase()} ?";
        }
      }

      // Si la personne ne s'élide pas
      else {
        // Si le temps commence par une consonne
        if (temps.typeDeTemps() == Temps.tempsCommenceParConsonne) {
          phrase =
              "\"$personne $forme\" est correct au ${temps.nom.toLowerCase()} ?";
        }

        // Si le temps commence par une voyelle
        else {
          phrase =
              "\"$personne $forme\" est correct à l'${temps.nom.toLowerCase()} ?";
        }
      }
    }
  }
}

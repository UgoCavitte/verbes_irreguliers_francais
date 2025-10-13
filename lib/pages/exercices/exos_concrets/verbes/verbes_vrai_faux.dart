import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/verbes/corrige_verbe_vrai_faux.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_exo_vrai_faux.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/forme_generee.dart';

import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';

/*
 * Cette classe permet de contrôler l'objet "modele exo vrai faux" pour les
 * verbes
 * 
 * Quand elle est appelée, elle reçoit :
 * 1. la quantité de questions qu'elle doit générer
 * 2. le verbe avec lequel l'étudiant veut travailler
 * 3. le ou les temps avec le ou lesquels l'étudiant veut travailler
 * 
 * Faire attention à ce que le nombre de questions n'excède pas le nombre de
 * formes possibles !
 * Il y a quand même une sécurité de 50 essais de générations par question
 */

class VerbesVraiFaux {
  final int quantite;
  final Verbe verbe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  VerbesVraiFaux(
      {required this.quantite,
      required this.verbe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionVraiFauxVerbe> questions = genererQuestions();

    // Créer une page selon "modele exo vrai faux" pour chaque question
    for (int i = 0; i < questions.length; i++) {
      questionsPretes.add(ModeleExoVraiFaux(
          vrai: questions[i].reponse,
          question: questions[i].phrase,
          onChanged: (bonBool) => onChanged(CorrigeVerbeVraiFaux(
              question: questions[i].phrase,
              choisiVraiOuFaux:
                  bonBool ? questions[i].reponse : !questions[i].reponse,
              bonneReponse: questions[i].bonneFormeSiFaux,
              bonOuPas: bonBool,
              idQst: i + nbrQstDejaFaites))));
    }
  }

  // Génère les questions

  /*
   * 1. Générer une forme
   * 2. Générer un nombre random qui permette de définir s'il faut que la
   *    réponse soit vraie ou fausse
   * 3.a. Si la réponse est vraie, ajouter à la liste
   * 3.b. Si la réponse est fausse, générer une autre forme
   *      "Faux" signifie que le temps et/ou la personne ne correspondent pas à
   *      la forme
   *      Ajouter à la liste
   */

  List<QuestionVraiFauxVerbe> genererQuestions() {
    List<QuestionVraiFauxVerbe> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // S'arrête une fois que la quantité de questions est atteinte
    for (int i = 0; i < quantite; i++) {
      // Étape 1
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: temps, verbe: verbe, dejaGenere: formesUtilisees);
      formesUtilisees.add(formeGeneree.forme);

      // Étapes 2 et 3 -> Bonne ou mauvaise réponse ?
      // Vrai (3.a)
      if (rng.nextBool()) {
        questions.add(QuestionVraiFauxVerbe(
            personne: formeGeneree.personne,
            forme: formeGeneree.forme,
            temps: formeGeneree.temps,
            reponse: true,
            bonneFormeSiFaux: formeGeneree.forme,
            verbe: verbe));
      }

      // Faux (3.b)
      else {
        // On ne passe que la bonne forme, pas besoin de vérifier les autres
        FormeGeneree fausseForme = FormeGeneree(
            tempsPossibles: temps,
            verbe: verbe,
            dejaGenere: [formeGeneree.forme]);

        /* Il faut vérifier que la personne ne correspond pas non plus
         * Sinon, comme le temps n'est pas dans la question, il peut
         * arriver que la même personne soit tirée au sort et donc que la
         * forme fausse fonctionne également !
         */

        int i = 0;
        for (i = 0;
            fausseForme.personne == formeGeneree.personne &&
                i < gnrExoNbrTentativesAvantEchec;
            i++) {
          fausseForme = FormeGeneree(
              tempsPossibles: temps,
              verbe: verbe,
              dejaGenere: [formeGeneree.forme]);
        }
        // Si la forme de la fausse et de la bonne formes correpond, alors on prend une forme d'un autre temps
        if (i >= 50) {
          List<Temps> tempsPossiblesAvecExclusion = verbe.getTempsPossibles();
          tempsPossiblesAvecExclusion.remove(formeGeneree.temps);
          fausseForme = FormeGeneree(
              tempsPossibles: tempsPossiblesAvecExclusion,
              verbe: verbe,
              dejaGenere: [formeGeneree.forme]);
        }

        questions.add(QuestionVraiFauxVerbe(
            personne: formeGeneree.personne,
            forme: fausseForme.forme,
            temps: formeGeneree.temps,
            reponse: false,
            bonneFormeSiFaux: formeGeneree.forme,
            verbe: verbe));
      }
    }

    return questions;
  }
}

class QuestionVraiFauxVerbe {
  final String personne;
  final String forme;
  final Temps temps;
  final bool reponse;
  final String bonneFormeSiFaux;
  final Verbe verbe;
  String phrase = "";

  QuestionVraiFauxVerbe(
      {required this.personne,
      required this.forme,
      required this.temps,
      required this.reponse,
      required this.bonneFormeSiFaux,
      required this.verbe}) {
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
      phrase =
          "${Verbe.numeroPersonneToTexte(personne)} de \"${verbe.infinitif.toLowerCase()}\" à l'impératif est \"$forme\" ?";
    }

    // Reste
    else {
      // Si la personne s'élide (càd "j'")
      if (personne == "J'") {
        phrase =
            "\"$personne$forme\" (${temps.nom.toLowerCase()}) est correct ?";
      }

      // Si la personne ne s'élide pas
      else {
        phrase =
            "\"$personne $forme\" (${temps.nom.toLowerCase()}) est correct ?";
      }
    }
  }
}

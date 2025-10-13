import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../constantes_exos.dart';
import '../../exos_corriges/groupes_verbaux/corrige_groupe_vrai_faux.dart';
import '../../exos_modeles/modele_exo_vrai_faux.dart';
import '../../forme_generee.dart';

/*
 * Cette classe permet de contrôler l'objet "modele exo vrai faux" pour les
 * groupes verbaux
 * 
 * Quand elle est appelée, elle reçoit :
 * 1. la quantité de questions qu'elle doit générer
 * 2. le verbe avec lequel l'étudiant veut travailler
 */

class GroupesVraiFaux {
  final int quantite;
  final SousGroupe sousGroupe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GroupesVraiFaux(
      {required this.quantite,
      required this.sousGroupe,
      required this.temps,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionVraiFauxGroupe> questions = genererQuestions();

    // Créer une page selon "modele exo vrai faux" pour chaque question
    for (int i = 0; i < questions.length; i++) {
      questionsPretes.add(ModeleExoVraiFaux(
          vrai: questions[i].reponse,
          question: questions[i].phrase,
          onChanged: (bonBool) => onChanged(CorrigeGroupeVraiFaux(
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
   * 1. Choisit un verbe dans le sous-groupe proposé
   * 2. Génère une forme
   * 3. Générer un nombre random qui permette de définir s'il faut que la
   *    réponse soit vraie ou fausse
   * 4.a. Si la réponse est vraie, ajouter à la liste
   * 4.b. Si la réponse est fausse, générer une autre forme avec le même verbe
   *      "Faux" signifie que le temps et/ou la personne ne correspondent pas à
   *      la forme
   *      Ajouter à la liste
   */

  List<QuestionVraiFauxGroupe> genererQuestions() {
    List<QuestionVraiFauxGroupe> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // S'arrête une fois que le nombre voulu de questions a été généré
    for (int i = 0; i < quantite; i++) {
      // Étape 1
      Verbe verbeChoisi = sousGroupe.verbeRandom(random: rng);

      // Étape 2
      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: temps,
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);

      formesUtilisees.add(formeGeneree.forme);

      // Étape 3 et 4
      // Vrai (4.a)
      if (rng.nextBool()) {
        questions.add(QuestionVraiFauxGroupe(
            verbe: verbeChoisi,
            personne: formeGeneree.personne,
            forme: formeGeneree.forme,
            temps: formeGeneree.temps,
            reponse: true,
            bonneFormeSiFaux: formeGeneree.forme));
      }

      // Faux (4.b)
      else {
        // On ne passe que la bonne forme, pas besoin de vérifier les autres
        FormeGeneree fausseForme = FormeGeneree(
            tempsPossibles: temps,
            verbe: verbeChoisi,
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
              tempsPossibles: verbeChoisi.getTempsPossibles(),
              verbe: verbeChoisi,
              dejaGenere: [formeGeneree.forme]);
        }

        // Si la forme de la fausse et de la bonne formes correpond, alors on prend une forme d'un autre temps
        if (i >= 50) {
          List<Temps> tempsPossiblesAvecExclusion =
              verbeChoisi.getTempsPossibles();
          tempsPossiblesAvecExclusion.remove(formeGeneree.temps);
          fausseForme = FormeGeneree(
              tempsPossibles: tempsPossiblesAvecExclusion,
              verbe: verbeChoisi,
              dejaGenere: [formeGeneree.forme]);
        }

        questions.add(QuestionVraiFauxGroupe(
            verbe: verbeChoisi,
            personne: formeGeneree.personne,
            forme: fausseForme.forme,
            temps: formeGeneree.temps,
            reponse: false,
            bonneFormeSiFaux: formeGeneree.forme));
      }
    }

    return questions;
  }
}

class QuestionVraiFauxGroupe {
  final Verbe verbe;
  final String personne;
  final String forme;
  final Temps temps;
  final bool reponse;
  final String bonneFormeSiFaux;
  String phrase = "";

  QuestionVraiFauxGroupe(
      {required this.verbe,
      required this.personne,
      required this.forme,
      required this.temps,
      required this.reponse,
      required this.bonneFormeSiFaux}) {
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

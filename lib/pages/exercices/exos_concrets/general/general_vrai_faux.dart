import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/forme_generee.dart';

import '../../../../data/temps.dart';
import '../../../../types/types_temps.dart';
import '../../../../types/types_verbes.dart';
import '../../constantes_exos.dart';
import '../../exos_corriges/verbes/corrige_verbe_vrai_faux.dart';
import '../../exos_modeles/modele_exo_vrai_faux.dart';

class GeneralVraiFaux {
  final int quantite;
  final int nbrQstDejaFaites;
  final ValueChanged<ModeleCorrige> onChanged;

  List<StatefulWidget> questionsPretes = [];

  // Constructeur
  GeneralVraiFaux(
      {required this.quantite,
      required this.nbrQstDejaFaites,
      required this.onChanged}) {
    List<QuestionVraiFauxGeneral> questions = genererQuestions();

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

  List<QuestionVraiFauxGeneral> genererQuestions() {
    List<QuestionVraiFauxGeneral> questions = [];
    List<String> formesUtilisees = [];

    Random rng = Random();

    // Un tour par question
    for (int i = 0; i < quantite; i++) {
      // Commence par choisir un verbe
      Verbe verbeChoisi = listeVerbes[rng.nextInt(listeVerbes.length)];

      // Le temps est choisi quand la forme est générée

      FormeGeneree formeGeneree = FormeGeneree(
          tempsPossibles: verbeChoisi.getTempsPossibles(),
          verbe: verbeChoisi,
          dejaGenere: formesUtilisees);
      formesUtilisees.add(formeGeneree.forme);

      // Si la réponse est "Vrai"
      if (rng.nextBool()) {
        questions.add(QuestionVraiFauxGeneral(
            personne: formeGeneree.personne,
            forme: formeGeneree.forme,
            temps: formeGeneree.temps,
            reponse: true,
            bonneFormeSiFaux: formeGeneree.forme,
            verbe: verbeChoisi));
      }

      // Si la réponse est "Faux"
      else {
        // On ne passe que la bonne forme, pas besoin de vérifier les autres
        FormeGeneree fausseForme = FormeGeneree(
            tempsPossibles: verbeChoisi.getTempsPossibles(),
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

        questions.add(QuestionVraiFauxGeneral(
            personne: formeGeneree.personne,
            forme: fausseForme.forme,
            temps: formeGeneree.temps,
            reponse: false,
            bonneFormeSiFaux: formeGeneree.forme,
            verbe: verbeChoisi));
      }
    }

    return questions;
  }
}

class QuestionVraiFauxGeneral {
  final String personne;
  final String forme;
  final Temps temps;
  final bool reponse;
  final String bonneFormeSiFaux;
  final Verbe verbe;
  String phrase = "";

  QuestionVraiFauxGeneral(
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

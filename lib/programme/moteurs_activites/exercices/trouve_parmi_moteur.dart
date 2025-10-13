import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_question_widget.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

/*
 * Cet exercice est la version "modernisée" de celle disponible dans l'onglet
 * de révision personnalisée
 * 
 * Les principes de cet exercice sont :
 * - une question est posée à l'utilisateur ;
 * - la question contient l'infinitif du verbe et le temps recherché ;
 * - plusieurs propositions de réponse ;
 * - les réponses proposées sont prises parmi les différentes formes du verbe.
 */

abstract class TrouveParmiMoteur {
  static List<TrouveParmiQuestionWidget> getQuestions(
      {required List<Verbe> verbes,
      required Temps temps,
      required bool grosseEtape,
      required void Function(bool) questionSuivante}) {
    List<QuestionTrouveParmi> listeQuestions = [];

    // Génère des questions pour chaque verbe à réviser
    for (var verbe in verbes) {
      List<List<String>> formes = verbe.modele.formes[temps]!;

      List<QuestionTrouveParmi> listeAAjouter = [];

      // Génère une question pour chaque forme
      for (int i = 0; i < formes[0].length; i++) {
        listeAAjouter
            .add(QuestionTrouveParmi(verbe: verbe, temps: temps, index: i));
      }

      // On raccourcit si l'étape est considérée comme grosse
      // La deuxième partie de la condition évite les problèmes avec les verbes
      // impersonnels
      if (grosseEtape && formes[0].length > 4) {
        listeAAjouter.shuffle();
        listeQuestions.addAll(listeAAjouter.getRange(0, 4).toList());
      } else {
        listeQuestions.addAll(listeAAjouter);
      }
    }

    listeQuestions.shuffle();

    List<TrouveParmiQuestionWidget> listeWidget = [];

    for (var qst in listeQuestions) {
      listeWidget.add(TrouveParmiQuestionWidget(
          key: UniqueKey(),
          phrase: qst.phrase,
          bonneForme: qst.bonneForme,
          faussesFormes: qst.faussesFormes,
          questionSuivanteOnChange: questionSuivante));
    }

    return listeWidget;
  }
}

class QuestionTrouveParmi {
  final Verbe verbe;
  final Temps temps;
  final int index;
  String phrase = "";
  String bonneForme = "";
  List<String> faussesFormes = [];

  QuestionTrouveParmi(
      {required this.verbe, required this.temps, required this.index}) {
    // Génère la phrase
    int typeDeTemps = temps.typeDeTemps();
    // Si c'est un participe
    if (typeDeTemps == Temps.tempsTypeParticipe) {
      phrase =
          "Le ${temps.nom.toLowerCase()} de \"${verbe.infinitif.toLowerCase()}\" est :";
    }

    // Impératif
    else if (temps.nom == nomImperatif) {
      phrase =
          "Quelle forme de \"${Verbe.numeroPersonneToTexte(verbe.modele.formes[temps]![0][index]).toLowerCase()}\" est correcte à l'impératif ?";
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

    // Génère la bonne forme
    bonneForme =
        "${Verbe.correctionPersonnes(verbe.modele.formes[temps]![0][index])} ${verbe.modele.formes[temps]![1][index]}";

    // Génère trois fausses formes
    Random random = Random();

    // Liste des fausses formes utilisées sans la personne
    List<String> faussesFormesSansPersonne = [];

    for (int i = 0; i < 3; i++) {
      // Génère une forme qui ne correspond pas à la bonne
      String fausseFormeTemp = "";
      // La boucle tourne tant que la forme ne diffère pas de la bonne et d'une
      // forme déjà prise
      do {
        // Choix du temps
        // Il faut choisir le temps précisément ici, sinon il y a un risque que
        // le temps présente uniquement des formes déjà prises, ce qui ferait
        // tourner la boucle à l'infini
        Temps tempsFaux = verbe.modele.formes.keys
            .toList()[random.nextInt(verbe.modele.formes.keys.length)];

        int indRandom =
            random.nextInt(verbe.modele.formes[tempsFaux]![0].length);

        fausseFormeTemp = verbe.modele.formes[tempsFaux]![1][indRandom];
      } while (fausseFormeTemp == verbe.modele.formes[temps]![1][index] ||
          faussesFormesSansPersonne.contains(fausseFormeTemp));

      faussesFormesSansPersonne.add(fausseFormeTemp);
      faussesFormes.add(
          "${Verbe.correctionPersonnes(verbe.modele.formes[temps]![0][index])} $fausseFormeTemp");
    }
  }
}

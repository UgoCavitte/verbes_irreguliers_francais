import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

import 'modele_question_suivante.dart';

/*
 * Dans cet exo, l'utilisateur a le choix entre 4 réponses
 * Une seule réponse est correcte
 * 
 */

class ModeleTrouveParmi extends StatefulWidget {
  final String question;
  final String bonneReponse;
  final List<String> mauvaisesReponses; // composé de 3 éléments
  final ValueChanged<String> onChanged;

  const ModeleTrouveParmi(
      {required this.question,
      required this.bonneReponse,
      required this.mauvaisesReponses,
      required this.onChanged,
      super.key});

  @override
  State<StatefulWidget> createState() => _ModeleTrouveParmiState();
}

class _ModeleTrouveParmiState extends State<ModeleTrouveParmi> {
  List<ElevatedButton> boutons = [];
  List<String> toutesLesReponses = [];
  bool repondu = false;
  bool bon = false;
  String reponseChoisie = "";

  @override
  Widget build(BuildContext context) {
    // Si l'utilisateur n'a pas encore répondu
    if (!repondu) {
      toutesLesReponses.clear();
      boutons.clear();
      // Crée une nouvelle liste avec toutes les réponses et change l'ordre des réponses
      toutesLesReponses = [...widget.mauvaisesReponses, widget.bonneReponse];
      toutesLesReponses.shuffle();

      for (int i = 0; i < 4; i++) {
        boutons.add(BoutonGros(
            text: toutesLesReponses[i],
            action: toutesLesReponses[i] == widget.bonneReponse
                ? bonneReponse
                : () {
                    mauvaiseReponse(toutesLesReponses[i]);
                  }));
      }
    }
    // Si l'utilisateur a déjà répondu
    else {
      for (int i = 0; i < 4; i++) {
        boutons.add(toutesLesReponses[i] == widget.bonneReponse
            ? BoutonGrosVert(text: toutesLesReponses[i], action: null)
            : BoutonGrosRouge(text: toutesLesReponses[i], action: null));
      }
    }

    // Crée la colonne avec la question et les boutons
    List<Padding> listPaddingQST = [];
    for (var btn in boutons) {
      listPaddingQST.add(Padding(
        padding: paddingGeneral,
        child: btn,
      ));
    }

    Column partieQST = Column(children: [
      Padding(padding: paddingGeneral, child: Text(widget.question)),
      ...listPaddingQST
    ]);

    // Si l'utilisateur a déjà répondu à la question
    late Container toAdd;
    if (repondu) {
      toAdd = ModeleQuestionSuivante(
          bon: bon,
          onChanged: () {
            repondu = false;
            widget.onChanged(reponseChoisie);
          });
    }

    return !repondu
        // L'utilisateur n'a pas encore répondu
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [partieQST],
          )
        // L'utilisateur a déjà répondu
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [partieQST, toAdd],
          );
  }

  void bonneReponse() {
    setState(() {
      repondu = true;
      bon = true;
      reponseChoisie = widget.bonneReponse;
      boutons.clear();
    });
  }

  void mauvaiseReponse(String label) {
    setState(() {
      repondu = true;
      bon = false;
      reponseChoisie = label;
      boutons.clear();
    });
  }
}

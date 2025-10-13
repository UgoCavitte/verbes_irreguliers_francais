import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_modeles/modele_question_suivante.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

/*
 * Le principe de cet exercice est de proposer une affirmation qui est soit
 * vraie soit fausse
 * L'utilisateur clique sur le bouton vrai ou sur le bouton faux
 */

class ModeleExoVraiFaux extends StatefulWidget {
  final bool vrai; // Est-ce que la réponse est "vrai" ?
  final String question;
  final ValueChanged<bool> onChanged;

  const ModeleExoVraiFaux(
      {required this.vrai,
      required this.question,
      required this.onChanged,
      super.key});

  @override
  State<StatefulWidget> createState() => _ModeleExoVraiFauxState();
}

class _ModeleExoVraiFauxState extends State<ModeleExoVraiFaux> {
  late ElevatedButton boutonVrai;
  late ElevatedButton boutonFaux;
  bool repondu = false;
  bool bon = false;

  @override
  Widget build(BuildContext context) {
    if (!repondu) {
      boutonVrai = BoutonGros(
          text: exosTxtVrai,
          action: widget.vrai ? bonneReponse : mauvaiseReponse);
      boutonFaux = BoutonGros(
          text: exosTxtFaux,
          action: widget.vrai ? mauvaiseReponse : bonneReponse);
    } else {
      boutonVrai = widget.vrai
          ? BoutonGrosVert(text: exosTxtVrai, action: null)
          : BoutonGrosRouge(text: exosTxtVrai, action: null);
      boutonFaux = widget.vrai
          ? BoutonGrosRouge(text: exosTxtFaux, action: null)
          : BoutonGrosVert(text: exosTxtFaux, action: null);
    }

    Column partieQST = Column(
      children: [
        Padding(
          padding: paddingGeneral,
          child: Text(widget.question),
        ),
        (Padding(
          padding: paddingGeneral,
          child: boutonVrai,
        )),
        Padding(
          padding: paddingGeneral,
          child: boutonFaux,
        )
      ],
    );

    // Si l'utilisateur a déjà répondu à la question
    late Container toAdd;
    if (repondu) {
      toAdd = ModeleQuestionSuivante(
          bon: bon,
          onChanged: () {
            repondu = false;
            widget.onChanged(bon);
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
    });
  }

  void mauvaiseReponse() {
    setState(() {
      repondu = true;
      bon = false;
    });
  }
}

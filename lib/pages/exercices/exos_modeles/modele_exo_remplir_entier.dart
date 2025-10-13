import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

import '../../../types/types_verbes.dart';
import 'modele_question_suivante.dart';

/*
 * Dans cet exo, l'utilisateur doit renseigner la forme entière du verbe
 * La personne doit être exclue ou inclue (à choisir !)
 */

class ModeleExoRemplirEntier extends StatefulWidget {
  final String question;
  final String personne;
  final String reponse;
  final ValueChanged<PaireBoolString>
      onChanged; // on renvoie la forme proposée par l'utilisateur et s'il a bien répondu

  const ModeleExoRemplirEntier(
      {required this.question,
      required this.personne,
      required this.reponse,
      required this.onChanged,
      super.key});

  @override
  State<StatefulWidget> createState() => _ModeleExoRemplirEntierState();
}

class _ModeleExoRemplirEntierState extends State<ModeleExoRemplirEntier> {
  late ElevatedButton boutonValider;
  bool repondu = false;
  bool bon = false;
  String formeRepondue = "";

  TextEditingController tfController = TextEditingController();
  late TextField textField;

  @override
  Widget build(BuildContext context) {
    if (!repondu) {
      tfController.text = Verbe.correctionPersonnes(widget.personne);
      textField = TextField(
        autofocus: true,
        controller: tfController,
        onSubmitted: (s) => verifierReponse(),
      );
      boutonValider = BoutonGros(text: exosTxtValider, action: verifierReponse);
    } else {
      boutonValider = bon
          ? BoutonGrosVert(text: exosTxtValider, action: null)
          : BoutonGrosRouge(text: exosTxtValider, action: null);
    }

    Column partieQST = Column(
      children: [
        Padding(
          padding: paddingGeneral,
          child: Text(
            widget.question,
            style: textStyleGeneral,
          ),
        ),
        Padding(padding: paddingGeneral, child: textField),
        Padding(
          padding: paddingGeneral,
          child: boutonValider,
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
            widget.onChanged(
                PaireBoolString(bonOuPas: bon, forme: formeRepondue));
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

  bool verifierReponse() {
    // On enlève la personne avant de vérifier si la proposition correspond à la bonne réponse
    formeRepondue = tfController.text.replaceFirst(widget.personne, "").trim();

    if (Verbe.verifierForme(
        formeCorrecte: widget.reponse, formeDonnee: formeRepondue)) {
      setState(() {
        repondu = true;
        bon = true;
      });
    } else {
      setState(() {
        repondu = true;
        bon = false;
      });
    }

    return true;
  }
}

class PaireBoolString {
  bool bonOuPas;
  String forme;

  PaireBoolString({required this.bonOuPas, required this.forme});
}

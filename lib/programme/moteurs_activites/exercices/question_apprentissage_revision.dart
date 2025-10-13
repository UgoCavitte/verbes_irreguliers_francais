import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

import '../../../types/types_boutons.dart';

const EdgeInsets _paddingDroit = EdgeInsets.fromLTRB(0, 0, 10, 0);

class QuestionApprentissageRevision extends StatefulWidget {
  final String phrase;
  final String personne;
  final String bonneReponse;
  final TypeEtape typeEtape;

  final void Function(bool) questionSuivanteOnChange;

  const QuestionApprentissageRevision(
      {super.key,
      required this.phrase,
      required this.personne,
      required this.bonneReponse,
      required this.typeEtape,
      required this.questionSuivanteOnChange});

  QuestionApprentissageRevision.remettre(
      {required Key key, required QuestionApprentissageRevision qst})
      : this(
            key: key,
            phrase: qst.phrase,
            personne: qst.personne,
            bonneReponse: qst.bonneReponse,
            typeEtape: qst.typeEtape,
            questionSuivanteOnChange: qst.questionSuivanteOnChange);

  @override
  State<StatefulWidget> createState() => _QuestionApprentissageRevisionState();
}

class _QuestionApprentissageRevisionState
    extends State<QuestionApprentissageRevision> {
  late ElevatedButton _boutonValider;

  final TextEditingController _controller = TextEditingController();
  late TextField _tf;

  bool _repondu = false;
  bool _bon = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // N'a pas répondu
    if (!_repondu) {
      _tf = TextField(
        autofocus: true,
        controller: _controller,
        onSubmitted: (s) => verifierReponse(),
      );
      _boutonValider =
          BoutonGros(text: stringValiderBouton, action: verifierReponse);
    }

    // A déjà répondu
    else {
      _boutonValider = _bon
          ? BoutonGrosVert(
              text: stringQstSuivanteBouton,
              action: () => widget.questionSuivanteOnChange(true))
          : BoutonGrosRouge(
              text: stringQstSuivanteBouton,
              action: () => widget.questionSuivanteOnChange(false));
    }

    // Soit le bouton de validation
    // Soit le container avec la bonne réponse si nécessaire et le bouton suite
    Widget partieBasse;

    if (!_repondu) {
      partieBasse = Padding(
        padding: paddingGeneral,
        child: _boutonValider,
      );
    } else {
      partieBasse = Container(
        padding: paddingGeneral,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextPaddAlign(
                text: _bon
                    ? "Bonne réponse !"
                    : 'Il fallait répondre "${widget.bonneReponse}"'),
            _boutonValider
          ],
        ),
      );
    }

    // Assemblage de la page
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextPaddAlign(text: widget.phrase),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextPaddAlign(text: Verbe.correctionPersonnes(widget.personne)),
            Expanded(child: Padding(padding: _paddingDroit, child: _tf))
          ],
        ),
        const Spacer(),
        partieBasse
      ],
    );
  }

  void verifierReponse() {
    if (Verbe.verifierForme(
        formeCorrecte: widget.bonneReponse,
        formeDonnee: _controller.text.trim())) {
      setState(() {
        _repondu = true;
        _bon = true;
      });
    } else {
      setState(() {
        _repondu = true;
        _bon = false;
      });
    }
  }
}

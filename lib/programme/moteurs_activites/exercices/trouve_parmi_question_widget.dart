import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

class TrouveParmiQuestionWidget extends StatefulWidget {
  final String phrase;
  final String bonneForme;
  final List<String> faussesFormes;
  final void Function(bool) questionSuivanteOnChange;

  const TrouveParmiQuestionWidget(
      {super.key,
      required this.phrase,
      required this.bonneForme,
      required this.faussesFormes,
      required this.questionSuivanteOnChange});

  TrouveParmiQuestionWidget.remettre(
      {required Key key, required TrouveParmiQuestionWidget trouveParmi})
      : this(
            key: key,
            phrase: trouveParmi.phrase,
            bonneForme: trouveParmi.bonneForme,
            faussesFormes: trouveParmi.faussesFormes,
            questionSuivanteOnChange: trouveParmi.questionSuivanteOnChange);

  @override
  State<StatefulWidget> createState() => _TrouveParmiQuestionWidgetState();
}

class _TrouveParmiQuestionWidgetState extends State<TrouveParmiQuestionWidget>
    with TickerProviderStateMixin {
  late AnimationController boutonBasAnimationController;

  late ElevatedButton boutonValider;

  List<String> listePropositions = [];

  late String formeChoisie;
  bool repondu = false;
  bool bon = false;

  @override
  void initState() {
    super.initState();

    boutonBasAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    listePropositions.add(widget.bonneForme);
    listePropositions.addAll(widget.faussesFormes);

    listePropositions.shuffle();
  }

  @override
  void dispose() {
    boutonBasAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A déjà répondu
    if (repondu) {
      boutonValider = bon
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

    if (!repondu) {
      partieBasse = const Padding(
        padding: paddingGeneral,
        child: Text(""),
      );
    } else {
      partieBasse = SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(boutonBasAnimationController),
          child: Container(
            padding: paddingGeneral,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextPaddAlign(
                    text: bon
                        ? "Bonne réponse !"
                        : 'Il fallait répondre "${widget.bonneForme}"'),
                boutonValider
              ],
            ),
          ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextPaddAlign(text: widget.phrase),
        Center(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...listePropositions.map((string) {
                  if (!repondu) {
                    return Padding(
                        padding: paddingGeneral,
                        child: BoutonGros(
                            text: string,
                            action: () {
                              checkReponse(string);
                            }));
                  }
                  // Si l'utilisateur a déjà répondu
                  else {
                    // La réponse choisie
                    if (string == formeChoisie) {
                      return Padding(
                          padding: paddingGeneral,
                          child: bon
                              ? BoutonGrosVert(text: string, action: () {})
                              : BoutonGrosRouge(text: string, action: () {}));
                    }
                    // Sinon
                    else {
                      return Padding(
                          padding: paddingGeneral,
                          child: BoutonGros(text: string, action: () {}));
                    }
                  }
                })
              ],
            ),
          ),
        ),
        const Spacer(),
        partieBasse
      ],
    );
  }

  void checkReponse(String contenu) {
    repondu = true;
    formeChoisie = contenu;

    if (contenu == widget.bonneForme) {
      bon = true;
    } else {
      bon = false;
    }

    // Animation
    boutonBasAnimationController.forward();

    setState(() {});
  }
}

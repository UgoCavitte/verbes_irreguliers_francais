import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';

import '../../data/constantes.dart';

class BoutonMelange extends StatefulWidget {
  final int id;
  final bool aEncadrer;
  final String text;
  final Colonne colonne;
  final void Function(int, String, RenvoiBoutonMelange) onChange;

  const BoutonMelange(
      {super.key,
      required this.id,
      required this.aEncadrer,
      required this.text,
      required this.colonne,
      required this.onChange});

  @override
  State<StatefulWidget> createState() => _BoutonMelangeState();
}

class _BoutonMelangeState extends State<BoutonMelange> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: widget.aEncadrer
            ? BoxDecoration(border: Border.all(color: rouge, width: 2))
            : BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 2)),
        margin: paddingGeneral,
        child: IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Afficher les flèches uniquement à droite
            _ContainerFinTexte(
              text: widget.text,
              colonne: widget.colonne,
            ),
            if (widget.colonne == Colonne.formes)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _TextBouton(
                          orientation: RenvoiBoutonMelange.haut,
                          onChange: () {
                            widget.onChange(widget.id, widget.text,
                                RenvoiBoutonMelange.haut);
                          }),
                    ),
                    Expanded(
                        child: _TextBouton(
                            orientation: RenvoiBoutonMelange.bas,
                            onChange: () {
                              widget.onChange(widget.id, widget.text,
                                  RenvoiBoutonMelange.bas);
                            }))
                  ]),
          ],
        )));
  }
}

class _ContainerFinTexte extends Container {
  final String text;
  final Colonne colonne;

  _ContainerFinTexte({required this.text, required this.colonne})
      : super(
            width: colonne == Colonne.personnes ? 90 : 110,
            height: 100,
            decoration:
                BoxDecoration(border: Border.all(color: couleurBordure)),
            child: TextPaddAlign(text: text));
}

class _TextBouton extends ElevatedButton {
  final RenvoiBoutonMelange orientation;
  final void Function() onChange;

  _TextBouton({required this.orientation, required this.onChange})
      : super(
            child: orientation == RenvoiBoutonMelange.haut
                ? iconFlecheHaut
                : iconFlecheBas,
            style: ElevatedButton.styleFrom(
                backgroundColor: bleu,
                foregroundColor: Colors.white,
                shape: const ContinuousRectangleBorder(side: BorderSide())),
            onPressed: () {
              onChange();
            });
}

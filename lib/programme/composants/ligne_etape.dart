import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/bouton_etape.dart';

import '../types/etape.dart';
import '../types/module.dart';
import 'check_box_etape.dart';

const EdgeInsetsGeometry _marginLigneEtape = EdgeInsets.fromLTRB(2, 1, 2, 1);

class LigneEtape extends StatefulWidget {
  // Étape en question
  final Etape etape;

  // Module en question
  final Module module;

  final void Function() onChangePageEntiere;

  const LigneEtape(
      {super.key,
      required this.etape,
      required this.module,
      required this.onChangePageEntiere});

  @override
  State<StatefulWidget> createState() => _LigneEtapeState();
}

class _LigneEtapeState extends State<LigneEtape> {
  // Checkbox que l'utilisateur peut cocher lui-même
  late CheckBoxEtape checkbox;

  @override
  Widget build(BuildContext context) {
    // Fonction de refresh
    void onChange() {
      widget.onChangePageEntiere();
      setState(() {});
    }

    return Container(
        color: widget.etape.fait ? vertClair : Colors.white,
        margin: _marginLigneEtape,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: CheckBoxEtape(
                    etape: widget.etape,
                    module: widget.module,
                    onChange: onChange)),
            Expanded(flex: 1, child: Text(widget.etape.rang.toString(), style: textStyleGeneral,)),
            Expanded(flex: 8, child: Text(widget.etape.description, style: textStyleGeneral)),
            Expanded(
                flex: 2,
                child: BoutonEtape(etape: widget.etape, module: widget.module))
          ],
        ));
  }
}

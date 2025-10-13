import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/programme/composants/check_box_module.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';

import '../../data/constantes.dart';
import '../types/module.dart';

TextStyle _textStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: taillePolice * 1.5);

class ExpansionModule extends StatefulWidget {
  final List<Widget> contenu;
  final Module module;
  final bool ouvertFerme;
  final void Function() onChangePageEntiere;

  const ExpansionModule(
      {super.key,
      required this.contenu,
      required this.module,
      required this.ouvertFerme,
      required this.onChangePageEntiere});

  @override
  State<StatefulWidget> createState() => _ExpansionModuleState();
}

class _ExpansionModuleState extends State<ExpansionModule> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingEntreModules,
        child: Container(
            decoration: BoxDecoration(gradient: gradientBleuBleuClair),
            child: ExpansionTile(
              title: TitreExpansionModule(
                  module: widget.module,
                  onChangePageEntiere: widget.onChangePageEntiere),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              initiallyExpanded: widget.ouvertFerme,
              children: widget.contenu,
            )));
  }
}

class TitreExpansionModule extends IntrinsicHeight {
  final Module module;
  final void Function() onChangePageEntiere;

  TitreExpansionModule(
      {super.key, required this.module, required this.onChangePageEntiere})
      : super(
            child: Row(children: [
          Expanded(flex: 3, child: Text(module.description, style: _textStyle)),
          const Expanded(
            flex: 1,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 3,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
                "${(module.getQtEtapesFaites() / module.etapes.length * 100).round()} %",
                style: _textStyle),
          ),
          Expanded(
              flex: 1,
              child: CheckBoxModule(
                  module: module, onChangePageEntiere: onChangePageEntiere))
        ]));
}

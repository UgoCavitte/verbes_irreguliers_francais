import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

import '../types/module.dart';

class CheckBoxModule extends StatefulWidget {
  final void Function() onChangePageEntiere;

  final Module module;

  const CheckBoxModule(
      {super.key, required this.module, required this.onChangePageEntiere});

  @override
  State<StatefulWidget> createState() => _CheckBoxModuleState();
}

class _CheckBoxModuleState extends State<CheckBoxModule> {
  late bool isChecked;

  @override
  Widget build(BuildContext context) {
    isChecked = widget.module.moduleFini();

    return Checkbox(
        shape: const CircleBorder(),
        activeColor: Colors.white,
        checkColor: vert,
        side: WidgetStateBorderSide.resolveWith(
            (states) => const BorderSide(width: 1.0, color: Colors.white)),
        value: isChecked,
        onChanged: (value) async {
          // On vérifie que la case n'est pas cochée, sinon il ne faut rien faire
          if (!isChecked) {
            if (await confirm(context,
                title: Text("Confirmez"),
                content: Text(
                    "Voulez-vous vraiment marquez toutes les étapes de ce module comme faites ?"),
                textOK: Text(
                  "Oui",
                  style: textStyleGeneral,
                ),
                textCancel: Text(
                  "Non",
                  style: textStyleGeneral,
                ))) {
              // Coche la case
              isChecked = true;
              // Marque toutes les étapes comme faites
              for (var etape in widget.module.etapes) {
                etape.marquerFaite(true);
              }
              widget.onChangePageEntiere();
            }
          }
        });
  }
}

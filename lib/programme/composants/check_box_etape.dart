import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

import '../../data/constantes.dart';
import '../types/etape.dart';

class CheckBoxEtape extends StatefulWidget {
  // Etape sur laquelle se base la checkbox
  final Etape etape;

  final Module module;

  final void Function() onChange;

  const CheckBoxEtape(
      {super.key,
      required this.etape,
      required this.module,
      required this.onChange});

  @override
  State<StatefulWidget> createState() => _CheckBoxEtapeState();
}

class _CheckBoxEtapeState extends State<CheckBoxEtape> {
  // Sa valeur
  late bool isChecked;

  @override
  Widget build(BuildContext context) {
    // Met à jour le statut selon le statut de l'étape concernée pour éviter
    // les désynchronisations
    isChecked = widget.etape.fait;

    return Checkbox(
        activeColor: vert,
        shape: const CircleBorder(),
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value ?? false;
            widget.etape.marquerFaite(value ?? false);
            if (value == true) {
              MyUser.moduleEnCours = widget.module;
              GestionMemoire.enregistrerModuleEnCours();
            }
            widget.onChange();
          });
        });
  }
}

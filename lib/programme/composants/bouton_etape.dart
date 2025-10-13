import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/main.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/moteur_apprentissage.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/moteur_revision.dart';

import '../../data/constantes.dart';
import '../types/etape.dart';
import '../types/module.dart';

class BoutonEtape extends StatefulWidget {
  final Etape etape;
  final Module module;

  const BoutonEtape({super.key, required this.etape, required this.module});

  @override
  State<StatefulWidget> createState() => _BoutonEtapeState();
}

class _BoutonEtapeState extends State<BoutonEtape> {
  @override
  Widget build(BuildContext context) {
    // Affiche un bouton play si l'étape n'a pas été faite
    if (!widget.etape.fait) {
      return IconButton(
        onPressed: action,
        icon: const Icon(Icons.play_arrow),
        color: rouge,
      );
    }
    // Affiche un bouton replay si l'étape n'a pas été faite
    else {
      return IconButton(
        onPressed: action,
        icon: const Icon(Icons.replay),
        color: rouge,
      );
    }
  }

  Future<void> action() async {
    final navigator = Navigator.of(context);

    // Recharger la limite au cas où le jour a changé
    _refreshMemoire();

    // Si la limite est atteinte et que l'utilisateur n'est pas premium
    if (MyUser.etapesFaitesAjd >= limiteEtapesAjd && !MyUser.isPremium) {
      if (await confirm(
        context,
        title: Text("Limite atteinte !"),
        content: Text(
          "Vous avez déjà fait trois étapes classiques aujourd'hui. Pour enlever la limite, veuillez passer par la boutique (disponible uniquement sur Android) ;)\nCette limite n'affecte pas le bouton de révisions quotidiennes.",
        ),
        textOK: Text(
          "Aller dans la boutique",
          style: textStyleGeneral,
        ),
        textCancel: Text(
          "Compris !",
          style: textStyleGeneral,
        ),
      )) {
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const HomePage(
                      index: 3,
                    )),
            (Route<dynamic> route) => false);
      }
    } else if (widget.etape.type == TypeEtape.apprentissage) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MoteurApprentissage(
                  etape: widget.etape, module: widget.module)));
    } else if (widget.etape.type == TypeEtape.revision) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MoteurRevision(etape: widget.etape, module: widget.module)));
    }
  }

  void _refreshMemoire() async {
    await GestionMemoire.chargerLimiteEtapes();
  }
}

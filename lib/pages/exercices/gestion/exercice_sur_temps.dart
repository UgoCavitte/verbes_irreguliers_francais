import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/temps/temps_remplir_entier.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/temps/temps_trouve_parmi.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/temps/temps_vrai_faux.dart';

import '../../../data/constantes.dart';
import '../../../types/types_temps.dart';
import '../constantes_exos.dart';
import '../exos_corriges/modele_corrige.dart';
import '../page_transition_fin_exo.dart';

class ExerciceSurTemps extends StatefulWidget {
  final Temps temps;
  final int nbrQstDejaFaites;

  const ExerciceSurTemps(
      {super.key, required this.temps, required this.nbrQstDejaFaites});

  @override
  State<StatefulWidget> createState() => _ExerciceSurTempsState();
}

class _ExerciceSurTempsState extends State<ExerciceSurTemps> {
  late TempsVraiFaux vraiFaux;
  late TempsTrouveParmi trouveParmi;
  late TempsRemplirEntier remplirEntier;

  late Widget toShow;

  List<ModeleCorrige> corriges = [];
  int idQst = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(txtAppBarReviser),
                  centerTitle: true,
                  foregroundColor: couleurTexteAppBar,
                  backgroundColor: couleurAppBar,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Padding(
                        padding: paddingGeneral,
                        child: Text(
                          idQst + 1 <= exoNbrTotalTemps
                              ? "${idQst + 1} / $exoNbrTotalTemps"
                              : "$exoNbrTotalTemps / $exoNbrTotalTemps",
                          style: textStyleCompteQuestions,
                        ))
                  ],
                ),
                backgroundColor: couleurBackgroundGeneral,
                body: getCurrentPage())));
  }

  Widget getCurrentPage() {
    // Génère les questions
    if (idQst == 0) {
      // Génère les Vrai/faux
      vraiFaux = TempsVraiFaux(
          quantite: exoNbrQstVFTemps,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // Génère les trouve parmi
      trouveParmi = TempsTrouveParmi(
          quantite: exoNbrQstTrouveParmiTemps,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites + exoNbrQstVFTemps,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // Remplir entier
      remplirEntier = TempsRemplirEntier(
          quantite: exoNbrQstRemplirEntierTemps,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites +
              exoNbrQstVFTemps +
              exoNbrQstTrouveParmiTemps,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });
    }

    // Renvoie les pages du Vrai/faux
    if (idQst < exoNbrQstVFTemps) {
      return vraiFaux.questionsPretes[idQst];
    }

    // Renvoie les pages du trouve parmi
    else if (idQst < exoNbrQstVFTemps + exoNbrQstTrouveParmiTemps) {
      return trouveParmi.questionsPretes[idQst - exoNbrQstVFTemps];
    }

    // Renvoie les pages du remplir entier
    else if (idQst <
        exoNbrQstVFTemps +
            exoNbrQstTrouveParmiTemps +
            exoNbrQstRemplirEntierTemps) {
      return remplirEntier.questionsPretes[
          idQst - exoNbrQstVFTemps - exoNbrQstTrouveParmiTemps];
    }

    // L'utilisateur a répondu à toutes les questions, alors on lui renvoie la page finale
    else {
      return PageTransitionFinExo(context: context, corriges: corriges);
    }
  }
}

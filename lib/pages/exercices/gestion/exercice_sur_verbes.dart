/*
 * Cette page doit permettre de servir et aux révisions, et à l'apprentissage
 */

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/page_transition_fin_exo.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/verbes/verbes_remplir_entier.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/verbes/verbes_trouve_parmi.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/verbes/verbes_vrai_faux.dart';

import '../../../data/constantes.dart';
import '../../../types/types_temps.dart';
import '../../../types/types_verbes.dart';
import '../exos_corriges/modele_corrige.dart';

class ExerciceSurVerbes extends StatefulWidget {
  const ExerciceSurVerbes(
      {required this.verbeAReviser,
      required this.tempsAReviser,
      required this.nbrQstDejaFaites,
      super.key});
  final Verbe verbeAReviser;
  final List<Temps> tempsAReviser;
  final int nbrQstDejaFaites;

  @override
  State<StatefulWidget> createState() => _ExerciceSurVerbesState();
}

class _ExerciceSurVerbesState extends State<ExerciceSurVerbes> {
  late VerbesVraiFaux vraiFaux;
  late VerbesTrouveParmi trouveParmi;
  late VerbesRemplirEntier remplirEntier;

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
                          idQst + 1 <= exoNbrTotalVerbe
                              ? "${idQst + 1} / $exoNbrTotalVerbe"
                              : "$exoNbrTotalVerbe / $exoNbrTotalVerbe",
                          style: textStyleCompteQuestions,
                        ))
                  ],
                ),
                backgroundColor: couleurBackgroundGeneral,
                body: getCurrentPage())));
  }

  Widget getCurrentPage() {
    if (idQst == 0) {
      // 1. Génère les vrai/faux
      vraiFaux = VerbesVraiFaux(
          quantite: exoNbrQstVFVerbe,
          verbe: widget.verbeAReviser,
          temps: widget.tempsAReviser,
          nbrQstDejaFaites: widget.nbrQstDejaFaites,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // 2. Génère les "Trouve parmi"
      trouveParmi = VerbesTrouveParmi(
          quantite: exoNbrQstTrouveParmiVerbe,
          verbe: widget.verbeAReviser,
          temps: widget.tempsAReviser,
          nbrQstDejaFaites: widget.nbrQstDejaFaites + exoNbrQstVFVerbe,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // 4. Génère les formes entières
      remplirEntier = VerbesRemplirEntier(
          quantite: exoNbrQstRemplirEntierVerbe,
          verbe: widget.verbeAReviser,
          temps: widget.tempsAReviser,
          nbrQstDejaFaites: widget.nbrQstDejaFaites +
              exoNbrQstVFVerbe +
              exoNbrQstTrouveParmiVerbe,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });
    }

    // Les X premières questions sont un vrai/faux
    if (idQst < exoNbrQstVFVerbe) {
      return vraiFaux.questionsPretes[idQst];
    }

    // Ensuite on passe au "Trouve parmi"
    else if (idQst < exoNbrQstVFVerbe + exoNbrQstTrouveParmiVerbe) {
      return trouveParmi.questionsPretes[idQst - exoNbrQstVFVerbe];
    }

    // Puis au "remplis"
    else if (idQst <
        exoNbrQstVFVerbe +
            exoNbrQstTrouveParmiVerbe +
            exoNbrQstRemplirEntierVerbe) {
      return remplirEntier.questionsPretes[
          idQst - exoNbrQstVFVerbe - exoNbrQstTrouveParmiVerbe];
    }

    // Page finale avec la note finale et les fautes
    else {
      return PageTransitionFinExo(context: context, corriges: corriges);
    }
  }
}

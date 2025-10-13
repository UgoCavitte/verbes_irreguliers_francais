import 'package:flutter/material.dart';

import '../../../data/constantes.dart';
import '../constantes_exos.dart';
import '../exos_concrets/general/general_remplir_entier.dart';
import '../exos_concrets/general/general_trouve_parmi.dart';
import '../exos_concrets/general/general_vrai_faux.dart';
import '../exos_corriges/modele_corrige.dart';
import '../page_transition_fin_exo.dart';

/*
 * Un exercice général doit concerner tous les verbes à tous les temps
 */

class ExerciceGeneral extends StatefulWidget {
  const ExerciceGeneral({super.key});

  @override
  State<StatefulWidget> createState() => _ExerciceGeneralState();
}

class _ExerciceGeneralState extends State<ExerciceGeneral> {
  late GeneralVraiFaux vraiFaux;
  late GeneralTrouveParmi trouveParmi;
  late GeneralRemplirEntier remplirEntier;

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
                          idQst + 1 <= exoNbrTotalGeneral
                              ? "${idQst + 1} / $exoNbrTotalGeneral"
                              : "$exoNbrTotalGeneral / $exoNbrTotalGeneral",
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
      // Vrai/faux
      vraiFaux = GeneralVraiFaux(
          quantite: exoNbrQstGeneralVF,
          nbrQstDejaFaites: 0,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // Trouve parmi
      trouveParmi = GeneralTrouveParmi(
          quantite: exoNbrQstGeneralTrouveParmi,
          nbrQstDejaFaites: exoNbrQstGeneralVF,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // Remplir entier
      remplirEntier = GeneralRemplirEntier(
          quantite: exoNbrQstGeneralRemplirEntier,
          nbrQstDejaFaites: exoNbrQstGeneralVF + exoNbrQstGeneralTrouveParmi,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // Puis pour un sous-groupe particulier
    }

    // Renvoie les pages
    // Vrai/faux
    if (idQst < exoNbrQstGeneralVF) {
      return vraiFaux.questionsPretes[idQst];
    }

    // Trouve parmi
    else if (idQst < exoNbrQstGeneralVF + exoNbrQstGeneralTrouveParmi) {
      return trouveParmi.questionsPretes[idQst - exoNbrQstGeneralVF];
    }

    // Remplir entier
    else if (idQst < exoNbrTotalGeneral) {
      return remplirEntier.questionsPretes[
          idQst - exoNbrQstGeneralVF - exoNbrQstGeneralTrouveParmi];
    }

    // Si l'utilisateur a répondu à toutes les questions, alors on lui renvoie la page de transition
    else {
      return PageTransitionFinExo(context: context, corriges: corriges);
    }
  }
}

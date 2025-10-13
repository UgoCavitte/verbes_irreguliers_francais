import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/groupes_verbaux/groupes_remplir_entier.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/groupes_verbaux/groupes_trouve_parmi.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_concrets/groupes_verbaux/groupes_vrai_faux.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

import '../../../data/constantes.dart';
import '../../../types/types_temps.dart';
import '../constantes_exos.dart';
import '../exos_corriges/modele_corrige.dart';
import '../page_transition_fin_exo.dart';

class ExerciceSurGroupesVerbaux extends StatefulWidget {
  final SousGroupe sousGroupe;
  final List<Temps> temps;
  final int nbrQstDejaFaites;

  const ExerciceSurGroupesVerbaux(
      {required this.sousGroupe,
      required this.temps,
      required this.nbrQstDejaFaites,
      super.key});

  @override
  State<StatefulWidget> createState() => _ExerciceSurGroupesVerbauxState();
}

class _ExerciceSurGroupesVerbauxState extends State<ExerciceSurGroupesVerbaux> {
  late GroupesVraiFaux vraiFaux;
  late GroupesTrouveParmi trouveParmi;
  late GroupesRemplirEntier remplirEntier;

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
                          idQst + 1 <= exoNbrTotalGroupe
                              ? "${idQst + 1} / $exoNbrTotalGroupe"
                              : "$exoNbrTotalGroupe / $exoNbrTotalGroupe",
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
      // 1. Génère les vrai/faux
      vraiFaux = GroupesVraiFaux(
          quantite: exoNbrQstVFGroupe,
          sousGroupe: widget.sousGroupe,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // 2. Génère les trouve parmi
      trouveParmi = GroupesTrouveParmi(
          quantite: exoNbrQstTrouveParmiGroupe,
          sousGroupe: widget.sousGroupe,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites + exoNbrQstVFGroupe,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });

      // 4. Génère les formes entières
      remplirEntier = GroupesRemplirEntier(
          quantite: exoNbrQstRemplirEntierGroupe,
          sousGroupe: widget.sousGroupe,
          temps: widget.temps,
          nbrQstDejaFaites: widget.nbrQstDejaFaites +
              exoNbrQstVFGroupe +
              exoNbrQstTrouveParmiGroupe,
          onChanged: (v) {
            setState(() {
              idQst++;
              corriges.add(v);
            });
          });
    }

    // Renvoie les pages du vrai faux
    if (idQst < exoNbrQstVFGroupe) {
      return vraiFaux.questionsPretes[idQst];
    }

    // Renvoie les pages du trouve parmi
    else if (idQst < exoNbrQstVFGroupe + exoNbrQstTrouveParmiGroupe) {
      return trouveParmi.questionsPretes[idQst - exoNbrQstVFGroupe];
    }

    // Renvoie les pages du remplir entier
    else if (idQst <
        exoNbrQstVFGroupe +
            exoNbrQstTrouveParmiGroupe +
            exoNbrQstRemplirEntierGroupe) {
      return remplirEntier.questionsPretes[
          idQst - exoNbrQstVFGroupe - exoNbrQstTrouveParmiGroupe];
    } else {
      return PageTransitionFinExo(context: context, corriges: corriges);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/constantes_exos.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

import '../../data/constantes.dart';
import '../../main.dart';

/*
 * Cette page est celle sur laquelle se retrouve l'utilisateur une fois qu'il
 * a fini une série d'exercices
 * Cette page doit :
 * 1. Afficher la note finale
 * 2. Afficher le détail des réponses
 * 3. Permettre de retourner :
 *    a. Au menu pour lancer des exos
 *    b. Au menu principal ? (Vraiment nécessaire ?)
 */

class ModelePageFinale extends StatefulWidget {
  final List<ModeleCorrige> contenuCorrige;

  const ModelePageFinale({required this.contenuCorrige, super.key});

  @override
  State<StatefulWidget> createState() => _ModelePageFinaleState();
}

class _ModelePageFinaleState extends State<ModelePageFinale> {
  int nbrDeBonnesReponses = 0;

  @override
  void initState() {
    for (var qst in widget.contenuCorrige) {
      if (qst.bonOuPas) nbrDeBonnesReponses++;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: const Text(txtAppBarResultats),
                centerTitle: true,
                foregroundColor: couleurTexteAppBar,
                backgroundColor: couleurAppBar,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage(
                                index: 0,
                              ))),
                ),
              ),
              backgroundColor: couleurBackgroundGeneral,
              body: ListView(
                children: [
                  // Note finale
                  Padding(
                      padding: paddingGeneral,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    "$txtNoteFinale $nbrDeBonnesReponses / ${widget.contenuCorrige.length}",
                                style: textStyleMessageCentral),
                          )
                        ],
                      )),

                  // Corrections
                  ...widget.contenuCorrige.map((a) => a.toShow),

                  // Bouton retour
                  Padding(
                    padding: paddingGeneral,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: BoutonGros(
                                text: txtQuitter,
                                action: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage(
                                              index: 0,
                                            ))))),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}

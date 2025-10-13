import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/programme/composants/bouton_melange.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

import '../../../types/types_temps.dart';
import '../../../types/types_verbes.dart';

/*
 * Cette exercice présente une conjugaison mélangée du verbe en cours
 * d'apprentissage
 * 
 * L'utilisateur doit remettre la conjugaison dans l'ordre
 */

// const EdgeInsetsGeometry _paddingBoutons = EdgeInsets.fromLTRB(10, 3, 10, 3);

List<String> _contenuPersonnes = [];
List<String> _contenuFormes = [];

class ConjugaisonMelange extends StatefulWidget {
  final Verbe verbe;
  final Temps temps;
  final void Function() ajouterTour;

  const ConjugaisonMelange(
      {super.key,
      required this.verbe,
      required this.temps,
      required this.ajouterTour});

  @override
  State<StatefulWidget> createState() => _ConjugaisonMelangeState();
}

class _ConjugaisonMelangeState extends State<ConjugaisonMelange> {
  // Cette liste définit quels boutons doivent être encadrés en rouge parce
  // qu'il a été déterminé qu'ils contiennent une mauvaise réponse
  List<int> _aEncadrerEnRouge = [];

  // Permet de savoir quel statut afficher (étape faite ou pas encore)
  bool _faitOuPas = false;

  /*
   * Cette fonction reçoit un callback de la part des boutons
   * 
   * Cette info doit contenir le type de colonne, la direction du changement et
   * la forme ou la personne concernée
  */
  void _changerOrdre(int id, String contenu, RenvoiBoutonMelange hautOuBas) {
    if (!_faitOuPas) {
      // On détermine le nouvel index en se basant sur l'index actuel et la
      //direction du changement
      int nvIndex = hautOuBas == RenvoiBoutonMelange.haut ? id - 1 : id + 1;

      // On vérifie que l'index ne fait pas sortir le bouton des limites (-1 ou
      // length)
      // On peut prendre n'importe quelle liste puisqu'elles font la même taille
      if (!(nvIndex == -1 || nvIndex >= _contenuPersonnes.length)) {
        List<String> temp = [];
        List<String> sansContenu = [];

        // On commence par exclure la forme à bouger via une liste temporaire
        for (int i = 0; i < _contenuFormes.length; i++) {
          if (i != id) {
            sansContenu.add(_contenuFormes[i]);
          }
        }

        // Puis on crée une liste avec le nouvel ordre
        if (nvIndex == 0) {
          temp.add(contenu);
        }

        for (int i = 0; i < sansContenu.length; i++) {
          temp.add(sansContenu[i]);

          if (i == nvIndex - 1) {
            temp.add(contenu);
          }
        }

        // Et on applique cette nouvelle liste à _contenuPersonnes
        _contenuFormes = temp;

        // Enlève les encadrés rouge
        _aEncadrerEnRouge = [];

        // recharge la page
        setState(() {
          //
        });
      }
    }
  }

  /*
   * Cette fonction reçoit un callback du bouton de validation en bas de la page
   * 
   * Elle doit vérifier que les index des formes et des personnes correspondent
   * 
   * Il faut bien vérifier le string au lieu de l'index pour éviter les
   * problèmes avec les verbes qui ont des formes qui se répètent
   */
  void _check() {
    _aEncadrerEnRouge = [];
    bool bonPasBon = true;

    List<List<String>> formes = widget.verbe.modele.formes[widget.temps]!;

    for (int i = 0; i < _contenuPersonnes.length; i++) {
      // D'abord, il faut trouver l'index de la personne
      int indexPersonne = formes[0]
          .indexOf(Verbe.correctionPersonnesInversee(_contenuPersonnes[i]));

      // Ensuite, on récupère la bonne forme
      String bonneForme = formes[1][indexPersonne];

      // Si ça ne correspond pas
      if (bonneForme != _contenuFormes[i]) {
        bonPasBon = false;
        _aEncadrerEnRouge.add(i);
      }
    }

    // Si tout est bon, on ajoute un tour
    if (bonPasBon) {
      setState(() {
        _faitOuPas = true;
      });
    }

    // Sinon, on recharge la page pour afficher les encadrements rouges
    else {
      setState(() {});
    }
  }

  /*
   * Première initialisation du widget
   * Il faut remplir les listes des personnes et des formes
   */
  @override
  void initState() {
    // Set la liste des personnes
    _contenuPersonnes.clear();
    _contenuPersonnes.addAll((widget.verbe.modele.formes[widget.temps]![0])
        .map((p) => Verbe.correctionPersonnes(p)));
    // Ne pas shuffle les personnes, sinon c'est pas clair

    // Set la liste des formes
    _contenuFormes.clear();
    _contenuFormes.addAll(widget.verbe.modele.formes[widget.temps]![1]);
    _contenuFormes.shuffle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Création du bouton de validation en fonction du statut
    ElevatedButton bouton;
    if (_faitOuPas) {
      bouton = BoutonGrosVert(
          text: stringContinuerBouton, action: widget.ajouterTour);
    } else {
      bouton = BoutonGros(text: stringVerifierBouton, action: _check);
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Personnes
                    _ColonneMelange(
                        aEncadrerEnRouge: _aEncadrerEnRouge,
                        contenu: _contenuPersonnes,
                        colonne: Colonne.personnes,
                        onChange: _changerOrdre),
                    // Formes du verbe
                    _ColonneMelange(
                        aEncadrerEnRouge: _aEncadrerEnRouge,
                        contenu: _contenuFormes,
                        colonne: Colonne.formes,
                        onChange: _changerOrdre)
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: paddingGeneral,
              decoration: const BoxDecoration(
                  border: BorderDirectional(
                      top: BorderSide(color: bleu, width: 3))),
              child: bouton)
        ]);
  }
}

class _ColonneMelange extends Container {
  final List<int> aEncadrerEnRouge;
  final List<String> contenu;
  final Colonne colonne;
  final Function(int, String, RenvoiBoutonMelange) onChange;

  _ColonneMelange(
      {required this.aEncadrerEnRouge,
      required this.contenu,
      required this.colonne,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getContenu(aEncadrerEnRouge, contenu, colonne, onChange),
    );
  }

  List<BoutonMelange> _getContenu(final List<int> aEncadrerEnRouge,
      List<String> contenu, Colonne colonne, onChange) {
    List<BoutonMelange> toReturn = [];

    for (int i = 0; i < contenu.length; i++) {
      toReturn.add(BoutonMelange(
          id: i,
          aEncadrer: aEncadrerEnRouge.contains(i),
          text: contenu[i],
          colonne: colonne,
          onChange: onChange));
    }

    return toReturn;
  }
}

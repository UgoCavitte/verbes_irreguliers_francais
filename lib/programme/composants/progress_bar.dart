import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

const EdgeInsetsGeometry _paddingProgressBar = EdgeInsets.fromLTRB(4, 2, 4, 2);

class ProgressBar extends StatelessWidget {
  // Index du verbe en cours ou partie de révision
  // Permet se savoir à quelle barre on se trouve maintenant
  final int indexGrosseEtape;

  // Nombres total de verbes vus ou 2 (révision)
  // Nombre de barres
  final int totalGrossesEtapes;

  /// ***************************************************************///
  /// Les deux variables suivantes sont nécessaires seulement pour   ///
  /// l'apprentissage.                                               ///
  ///****************************************************************///

  // Index de la partie du verbe en cours
  // Étape à l'intérieur de la barre en cours
  final int indexPartie;

  // Nombre de parties totales pour le verbes en cours
  // Nombre d'étapes dans la barre en cours
  final int totalParties;

  const ProgressBar({
    super.key,
    required this.indexGrosseEtape,
    required this.totalGrossesEtapes,
    required this.indexPartie,
    required this.totalParties,
  });

  @override
  Widget build(BuildContext context) {
    List<Progression> liste = [];

    // Si la barre a déjà été faite
    int i = 0;
    while (i < indexGrosseEtape) {
      liste.add(progressionComplete);
      i++;
    }

    // Quand on tombe sur la barre en cours
    liste.add(Progression(fait: indexPartie.toDouble(), total: totalParties));

    // Puis du vide pour les verbes à venir
    while (i < totalGrossesEtapes - 1) {
      liste.add(progressionNulle);
      i++;
    }

    List<Widget> listeElements = [];

    // boucle sur les éléments de la liste et crée des ProgressBarElements pour chaque
    for (var prog in liste) {
      listeElements.add(Expanded(
          child: Padding(
              padding: _paddingProgressBar,
              child: LinearProgressIndicator(
                value: prog.getValue(),
                color: Colors.amber,
                backgroundColor: grisClair,
              ))));
    }

    return Row(
      children: listeElements,
    );
  }
}

// Constante
final Progression progressionComplete = Progression(fait: 1, total: 1);
final Progression progressionNulle = Progression(fait: 0, total: 1);

class Progression {
  final double fait;
  final int total;
  Progression({required this.fait, required this.total});

  double getValue() {
    return fait / total;
  }
}

import 'package:flutter/material.dart';

import '../data/constantes.dart';

enum TypeEtape { apprentissage, revision, revisionGenerale }

enum RenvoiBoutonMelange { haut, bas }

enum Colonne { personnes, formes }

const EdgeInsets paddingEntreModules = EdgeInsets.fromLTRB(0, 10, 0, 10);
EdgeInsets paddingTitre = const EdgeInsets.all(5);

TextStyle textStyleMessageFinal =
    const TextStyle(color: bleu, fontSize: 22, fontWeight: FontWeight.bold);

// String
const String stringContinuerBouton = "Continuer";
const String stringCommencerBouton = "Commencer";
const String stringVerifierBouton = "Vérifier";
const String stringValiderBouton = "Valider";
const String stringQstSuivanteBouton = "Question suivante";
const String stringTerminerBouton = "Terminer";
const String stringReviser = "Réviser";

// Icones
const Icon iconFlecheBas = Icon(
  Icons.arrow_downward,
  color: Colors.white,
);
const Icon iconFlecheHaut = Icon(
  Icons.arrow_upward,
  color: Colors.white,
);

// Index apprentissage
const int indexPresentation = 0;
const int indexConjugaisonMelangee = 1;
const int indexQuestionsApprentissage = 2;
const int totalPartiesApprentissage = 3;

// Index révision
const int indexTrouveParmi = 0;
const int indexQuestionsRevision = 1;
const int totalPartiesRevision = 2;

// Autres
const int considererCommeGrossseEtape = 6;

// Limites
const int limiteEtapesAjd = 3;
const int limitesRevQuot = 1;

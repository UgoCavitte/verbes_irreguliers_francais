/*
 * Ce module porte sur les verbes irréguliers au présent
 * Le module comprend un certain nombre d'étapes détaillées dans ce fichier.
 */

// LISTE DES VERBES IRREGULIERS A CE TEMPS

/*
 * Aller
 * Avoir
 * Être
 * Savoir
 */

import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';

import '../types/module.dart';

class ModuleImperatif extends Module {
  ModuleImperatif() {
    id = "imper1";

    // Création des étapes
    etapes = [EtapeImperatif01(), EtapeImperatif02(), EtapeImperatif03()];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Impératif";
  }
}

// Pour éviter de préciser le temps à chaque étape
abstract class EtapeImperatif extends Etape {
  EtapeImperatif() {
    temps = TempsImperatif();
  }
}

// Étape 1
// Apprendre
// Verbes : aller, savoir
class EtapeImperatif01 extends EtapeImperatif {
  EtapeImperatif01() {
    id = "imper1_01";
    type = TypeEtape.apprentissage;
    description = 'Verbes "aller" et "savoir".';
    contenu = [Aller(), Savoir()];
  }
}

// Étape 2
// Apprendre
// Verbes : avoir, être
class EtapeImperatif02 extends EtapeImperatif {
  EtapeImperatif02() {
    id = "imper1_02";
    type = TypeEtape.apprentissage;
    description = 'Verbes "avoir" et "être".';
    contenu = [Avoir(), Etre()];
  }
}

// Étape 3
// Révision
// Verbes : aller, avoir, être, savoir
class EtapeImperatif03 extends EtapeImperatif {
  EtapeImperatif03() {
    id = "imper1_03";
    type = TypeEtape.revision;
    description = 'Révision générale.';
    contenu = [Aller(), Savoir(), Avoir(), Etre()];
  }
}

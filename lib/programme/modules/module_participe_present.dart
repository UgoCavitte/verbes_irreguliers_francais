import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Verbes vus dans ce module :
 */

class ModuleParticipePresent extends Module {
  ModuleParticipePresent() {
    id = "ppr1";

    // Création des étapes
    etapes = [EtapeParticipePresent01(), EtapeParticipePresent02()];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = 'Participe présent';
  }
}

abstract class EtapeParticipePresent extends Etape {
  EtapeParticipePresent() {
    temps = TempsParticipePresent();
  }
}

// Étape 1
// Apprentissage
// Avoir, être, savoir
class EtapeParticipePresent01 extends EtapeParticipePresent {
  EtapeParticipePresent01() {
    id = "ppr1_01";
    type = TypeEtape.apprentissage;
    description = '"Avoir", "être" et "savoir".';
    contenu = [Avoir(), Etre(), Savoir()];
  }
}

// Étape 2
// Révision
// 1
class EtapeParticipePresent02 extends EtapeParticipePresent {
  EtapeParticipePresent02() {
    id = "ppr1_02";
    type = TypeEtape.revision;
    description = 'Révision des verbes avec un participe présent irrégulier.';
    contenu = [Avoir(), Etre(), Savoir()];
  }
}

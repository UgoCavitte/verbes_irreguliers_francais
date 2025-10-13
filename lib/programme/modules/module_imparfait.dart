import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

class ModuleImparfait extends Module {
  ModuleImparfait() {
    id = "impar1";

    // Création des étapes
    etapes = [EtapeImparfait01(), EtapeImparfait02()];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Imparfait";
  }
}

abstract class EtapeImparfait extends Etape {
  EtapeImparfait() {
    temps = TempsImparfait();
  }
}

// Étape 1
// Apprentissage
// Être
class EtapeImparfait01 extends EtapeImparfait {
  EtapeImparfait01() {
    id = "impar1_01";
    type = TypeEtape.apprentissage;
    description = 'L\'unique verbe irrégulier à l\'imparfait : "être"';
    contenu = [Etre()];
  }
}

// Étape 2
// Révision
// Être
class EtapeImparfait02 extends EtapeImparfait {
  EtapeImparfait02() {
    id = "impar1_02";
    type = TypeEtape.revision;
    description = 'Révision du verbe "être"';
    contenu = [Etre()];
  }
}

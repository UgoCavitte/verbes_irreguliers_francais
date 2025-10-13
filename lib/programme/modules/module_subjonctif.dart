import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Verbes vus dans ce module :
 * 
 * Aller
 * Avoir
 * Boire
 * Être
 * Faire
 * Falloir
 * Mourir
 * Pleuvoir
 * Pouvoir
 * Savoir
 * Valoir
 * Vouloir
 * 
 * # -enir :
 * Tenir : appartenir, détenir, obtenir, retenir, soutenir
 * Venir : convenir, devenir, parvenir, prévenir, revenir, se souvenir
 * 
 * # -evoir :
 * Apercevoir, décevoir, recevoir
 * Devoir
 * 
 * # prendre :
 * Apprendre
 * Comprendre
 * Prendre
 * Surprendre
 * 
 * Ajouts tardifs :
 * S'asseoir
 * 
 */

class ModuleSubjonctif extends Module {
  ModuleSubjonctif() {
    id = "s1";

    etapes = [
      EtapeSubjonctif01(),
      EtapeSubjonctif02(),
      EtapeSubjonctif03(),
      EtapeSubjonctif04(),
      EtapeSubjonctif05(),
      EtapeSubjonctif06(),
      EtapeSubjonctif07(),
      EtapeSubjonctif08(),
      EtapeSubjonctif09(),
      EtapeSubjonctif10(),
      EtapeSubjonctif11(),
      EtapeSubjonctif12()
    ];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Subjonctif présent";
  }
}

abstract class EtapeSubjonctif extends Etape {
  EtapeSubjonctif() {
    temps = TempsSubjonctif();
  }
}

// Étape 1
// Apprentissage
// Avoir, Être, faire
class EtapeSubjonctif01 extends EtapeSubjonctif {
  EtapeSubjonctif01() {
    id = "s1_01";
    type = TypeEtape.apprentissage;
    description = '"Avoir", "être" et "faire".';
    contenu = [Avoir(), Etre(), Faire()];
  }
}

// Étape 2
// Apprentissage
// Radical changeant : aller, mourir, vouloir
class EtapeSubjonctif02 extends EtapeSubjonctif {
  EtapeSubjonctif02() {
    id = "s1_02";
    type = TypeEtape.apprentissage;
    description = 'Radical changeant : "aller", "mourir" et "vouloir".';
    contenu = [Aller(), Mourir(), Vouloir()];
  }
}

// Étape 3
// Révision
// 1 2
class EtapeSubjonctif03 extends EtapeSubjonctif {
  EtapeSubjonctif03() {
    id = "s1_03";
    type = TypeEtape.revision;
    description = 'Révision des verbes des deux premières étapes.';
    contenu = [Avoir(), Etre(), Faire(), Aller(), Mourir(), Vouloir()];
  }
}

// Étape 4
// Apprentissage
// -tenir
class EtapeSubjonctif04 extends EtapeSubjonctif {
  EtapeSubjonctif04() {
    id = "s1_04";
    type = TypeEtape.apprentissage;
    description = '"Tenir" et ses composés.';
    contenu = [
      Tenir(),
      Appartenir(),
      Detenir(),
      Obtenir(),
      Retenir(),
      Soutenir()
    ];
  }
}

// Étape 5
// Apprentissage
// -venir
class EtapeSubjonctif05 extends EtapeSubjonctif {
  EtapeSubjonctif05() {
    id = "s1_05";
    type = TypeEtape.apprentissage;
    description = '"Venir" et ses composés.';
    contenu = [
      Venir(),
      Convenir(),
      Devenir(),
      Parvenir(),
      Prevenir(),
      Revenir(),
      SeSouvenir()
    ];
  }
}

// Étape 6
// Révision
// 4 5
class EtapeSubjonctif06 extends EtapeSubjonctif {
  EtapeSubjonctif06() {
    id = "s1_06";
    type = TypeEtape.revision;
    description = 'Révision des verbes en -enir.';
    contenu = [
      Tenir(),
      Appartenir(),
      Detenir(),
      Obtenir(),
      Retenir(),
      Soutenir(),
      Venir(),
      Convenir(),
      Devenir(),
      Parvenir(),
      Prevenir(),
      Revenir(),
      SeSouvenir()
    ];
  }
}

// Étape 7
// Apprentissage
// -prendre
class EtapeSubjonctif07 extends EtapeSubjonctif {
  EtapeSubjonctif07() {
    id = "s1_07";
    type = TypeEtape.apprentissage;
    description = '"Prendre" et ses composés.';
    contenu = [Prendre(), Apprendre(), Comprendre(), Surprendre()];
  }
}

// Étape 8
// Apprentissage
// -evoir
class EtapeSubjonctif08 extends EtapeSubjonctif {
  EtapeSubjonctif08() {
    id = "s1_08";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -evoir.';
    contenu = [Devoir(), Apercevoir(), Decevoir(), Recevoir()];
  }
}

// Étape 9
// Révision
// 7 8
class EtapeSubjonctif09 extends EtapeSubjonctif {
  EtapeSubjonctif09() {
    id = "s1_09";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 7 et 8.';
    contenu = [
      Prendre(),
      Apprendre(),
      Comprendre(),
      Surprendre(),
      Devoir(),
      Apercevoir(),
      Decevoir(),
      Recevoir()
    ];
  }
}

// Étape 10
// Apprentissage
// Boire, valoir
class EtapeSubjonctif10 extends EtapeSubjonctif {
  EtapeSubjonctif10() {
    id = "s1_10";
    type = TypeEtape.apprentissage;
    description = 'Radical changeant : "boire" et "valoir".';
    contenu = [Boire(), Valoir()];
  }
}

// Étape 11
// Apprentissage
// Falloir, pleuvoir, s'asseoir
class EtapeSubjonctif11 extends EtapeSubjonctif {
  EtapeSubjonctif11() {
    id = "s1_11";
    type = TypeEtape.apprentissage;
    description =
        'Verbes impersonnels : "falloir" et "pleuvoir" + "s\'asseoir".';
    contenu = [Falloir(), Pleuvoir(), SAsseoir()];
  }
}

// Étape 12
// Apprentissage
// Pouvoir, savoir
class EtapeSubjonctif12 extends EtapeSubjonctif {
  EtapeSubjonctif12() {
    id = "s1_12";
    type = TypeEtape.apprentissage;
    description = '"Pouvoir" et "savoir".';
    contenu = [Pouvoir(), Savoir()];
  }
}

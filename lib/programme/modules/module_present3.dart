import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Ce module est la suite des deux premiers modules sur le présent
 * Il doit être le module final !
 */

/*
 * Les verbes irréguliers présentés dans ce module sont :
 * 
 * Battre
 * Conclure
 * Cueillir, accueillir
 * Naitre
 * Plaire
 * Servir
 * Suffire
 * Suivre
 * Se taire
 * Vaincre, accueillir
 * Valoir
 * 
 * Groupe -uire
 * Groupe -oudre
 * 
 * Dont le radical a déjà été vu :
 * Réécrire
 * Surprendre
 * Transmettre
 * Prédire
 * Projeter, rejeter
 * Geler, lever, peser
 * Appartenir, détenir, soutenir
 * Convenir, parvenir, prévenir, revenir, se souvenir
 * 
 * Ajouts tardifs :
 * S'asseoir
 * 
 */

class ModulePresent3 extends Module {
  ModulePresent3() {
    id = "pr3";

    // Création des étapes
    etapes = [
      EtapePresentm3e01(),
      EtapePresentm3e02(),
      EtapePresentm3e03(),
      EtapePresentm3e04(),
      EtapePresentm3e05(),
      EtapePresentm3e06(),
      EtapePresentm3e07(),
      EtapePresentm3e08(),
      EtapePresentm3e09(),
      EtapePresentm3e10(),
      EtapePresentm3e11(),
      EtapePresentm3e12(),
      EtapePresentm3e13(),
      EtapePresentm3e14(),
      EtapePresentm3e15(),
      EtapePresentm3e16(),
      EtapePresentm3e17(),
      EtapePresentm3e18(),
      EtapePresentm3e19()
    ];

    // Numérotation
    numeroterEtapes();

    // Création de la description
    description = 'Présent - Partie 3';
  }
}

// Étape 1
// Apprentissage
// Verbes en -uire -> conduire, cuire, construire, détruire, traduire
class EtapePresentm3e01 extends EtapePresent {
  EtapePresentm3e01() {
    id = "pr3_01";
    type = TypeEtape.apprentissage;
    description =
        'Verbes en -uire : "conduire", "cuire", "construire", "détruire" et "traduire".';
    contenu = [Conduire(), Cuire(), Construire(), Detruire(), Traduire()];
  }
}

// Étape 2
// Apprentissage
// Verbes en -uire -> introduire, produire, réduire, séduire
class EtapePresentm3e02 extends EtapePresent {
  EtapePresentm3e02() {
    id = "pr3_02";
    type = TypeEtape.apprentissage;
    description =
        'Verbes en -uire : "introduire", "produire", "réduire" et "séduire".';
    contenu = [Introduire(), Produire(), Reduire(), Seduire()];
  }
}

// Étape 3
// Apprentissage
// Verbes en -uire -> déduire, luire, nuire
class EtapePresentm3e03 extends EtapePresent {
  EtapePresentm3e03() {
    id = "pr3_03";
    type = TypeEtape.apprentissage;
    description = 'Derniers verbes en -uire : "déduire", "luire" et "nuire".';
    contenu = [Deduire(), Luire(), Nuire()];
  }
}

// Étape 4
// Révision
// Verbes en -uire
class EtapePresentm3e04 extends EtapePresent {
  EtapePresentm3e04() {
    id = "pr3_04";
    type = TypeEtape.revision;
    description = 'Révision des verbes en -uire.';
    contenu = [
      Conduire(),
      Cuire(),
      Construire(),
      Detruire(),
      Traduire(),
      Introduire(),
      Produire(),
      Reduire(),
      Seduire(),
      Deduire(),
      Luire(),
      Nuire()
    ];
  }
}

// Étape 5
// Apprentissage
// Naître, plaire, battre, suffire
class EtapePresentm3e05 extends EtapePresent {
  EtapePresentm3e05() {
    id = "pr3_05";
    type = TypeEtape.apprentissage;
    description = '"Naître", "plaire", "battre" et "suffire".';
    contenu = [Naitre(), Plaire(), Battre(), Suffire()];
  }
}

// Étape 6
// Apprentissage
// Servir, suivre, valoir
class EtapePresentm3e06 extends EtapePresent {
  EtapePresentm3e06() {
    id = "pr3_06";
    type = TypeEtape.apprentissage;
    description = '"Servir", "suivre" et "valoir".';
    contenu = [Servir(), Suivre(), Valoir()];
  }
}

// Étape 7
// Révision
// 5 et 6
class EtapePresentm3e07 extends EtapePresent {
  EtapePresentm3e07() {
    id = "pr3_07";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 5 et 6.';
    contenu = [
      Naitre(),
      Plaire(),
      Battre(),
      Suffire(),
      Servir(),
      Suivre(),
      Valoir()
    ];
  }
}

// Étape 8
// Apprentissage
// Accueillir, cueillir
class EtapePresentm3e08 extends EtapePresent {
  EtapePresentm3e08() {
    id = "pr3_08";
    type = TypeEtape.apprentissage;
    description = '"Cueillir", "accueillir".';
    contenu = [Cueillir(), Accueillir()];
  }
}

// Étape 9
// Apprentissage
// Vaincre, convaincre
class EtapePresentm3e09 extends EtapePresent {
  EtapePresentm3e09() {
    id = "pr3_09";
    type = TypeEtape.revision;
    description = '"Vaincre", "convaincre".';
    contenu = [Vaincre(), Convaincre()];
  }
}

// Étape 10
// Apprentissage
// Verbes en -oudre
class EtapePresentm3e10 extends EtapePresent {
  EtapePresentm3e10() {
    id = "pr3_10";
    type = TypeEtape.revision;
    description = 'Verbes en -oudre.';
    contenu = [Coudre(), Moudre(), Resoudre()];
  }
}

// Étape 11
// Révision
// 8 9 10
class EtapePresentm3e11 extends EtapePresent {
  EtapePresentm3e11() {
    id = "pr3_11";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 8, 9 et 10.';
    contenu = [
      Cueillir(),
      Accueillir(),
      Vaincre(),
      Convaincre(),
      Coudre(),
      Moudre(),
      Resoudre()
    ];
  }
}

// Étape 12
// Apprentissage
// Conclure, se taire, s'asseoir
class EtapePresentm3e12 extends EtapePresent {
  EtapePresentm3e12() {
    id = "pr3_12";
    type = TypeEtape.apprentissage;
    description = 'Derniers verbes : "conclure", "se taire" et "s\'asseoir".';
    contenu = [Conclure(), SeTaire(), SAsseoir()];
  }
}

// Étape 13
// Révision
// Conclure, se taire, s'asseoir
class EtapePresentm3e13 extends EtapePresent {
  EtapePresentm3e13() {
    id = "pr3_13";
    type = TypeEtape.revision;
    description =
        'Révision des derniers verbes : "conclure", "se taire" et "s\'asseoir".';
    contenu = [Conclure(), SeTaire(), SAsseoir()];
  }
}

// Étape 14
// Apprentissage
// Réécrire, surprendre, transmettre, prédire
class EtapePresentm3e14 extends EtapePresent {
  EtapePresentm3e14() {
    id = "pr3_14";
    type = TypeEtape.apprentissage;
    description =
        'Composés de verbes déjà appris : "réécrire", "surprendre", "transmettre", "prédire" et "maudire".';
    contenu = [Reecrire(), Surprendre(), Transmettre(), Predire(), Maudire()];
  }
}

// Étape 15
// Apprentissage
// Projeter, rejeter, geler, lever, peser
class EtapePresentm3e15 extends EtapePresent {
  EtapePresentm3e15() {
    id = "pr3_15";
    type = TypeEtape.apprentissage;
    description =
        'E*er et exceptions : "projeter", "rejeter", "geler", "lever" et "peser".';
    contenu = [Projeter(), Rejeter(), Geler(), Lever(), Peser()];
  }
}

// Étape 16
// Révision
// 14 et 15
class EtapePresentm3e16 extends EtapePresent {
  EtapePresentm3e16() {
    id = "pr3_16";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 14 et 15.';
    contenu = [
      Reecrire(),
      Surprendre(),
      Transmettre(),
      Predire(),
      Projeter(),
      Rejeter(),
      Geler(),
      Lever(),
      Peser()
    ];
  }
}

// Étape 17
// Apprentissage
// Appartenir, détenir, soutenir
class EtapePresentm3e17 extends EtapePresent {
  EtapePresentm3e17() {
    id = "pr3_17";
    type = TypeEtape.apprentissage;
    description =
        'Composés de "tenir" : "appartenir", "détenir" et "soutenir".';
    contenu = [Appartenir(), Detenir(), Soutenir()];
  }
}

// Étape 18
// Apprentissage
// Convenir, parvenir, prévenir, revenir, se souvenir
class EtapePresentm3e18 extends EtapePresent {
  EtapePresentm3e18() {
    id = "pr3_18";
    type = TypeEtape.apprentissage;
    description =
        'Composés de "venir" : "convenir", "parvenir", "prévenir", "revenir" et "se souvenir".';
    contenu = [Convenir(), Parvenir(), Prevenir(), Revenir(), SeSouvenir()];
  }
}

// Étape 19
// Révision
// 17 et 18
class EtapePresentm3e19 extends EtapePresent {
  EtapePresentm3e19() {
    id = "pr3_19";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 17 et 18.';
    contenu = [
      Appartenir(),
      Detenir(),
      Soutenir(),
      Convenir(),
      Parvenir(),
      Prevenir(),
      Revenir(),
      SeSouvenir()
    ];
  }
}

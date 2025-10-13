import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Ce module est celui du futur simple
 * 
 * Le nombre de verbes irréguliers au futur simple devrait permettre de ne pas
 * diviser ce temps en plusieurs modules
 */

/*
 * Verbes étudiés dans ce module :
 * 
 * Accueillir, cueillir
 * Aller
 * Avoir
 * Courir, parcourir
 * Envoyer
 * Être
 * Falloir
 * Mourir
 * Pleuvoir
 * Savoir
 * Valoir
 * Voir, prévoir
 * 
 * 
 * Verbes en -enir
 * -> venir, devenir, prévenir, se souvenir
 * -> tenir, retenir, obtenir, soutenir
 * 
 * Dans un second temps :
 * Appartenir, détenir
 * Convenir, parvenir, revenir
 * 
 * Verbes en -evoir -> devoir, apercevoir, décevoir, recevoir
 * 
 * Appeler/Jeter
 * Projeter, rejeter
 * 
 * Groupe e*er é*er
 * Acheter, geler, lever, se lever, peser, se peser
 * Céder
 * 
 * Ajouts tardifs :
 * S'asseoir
 * 
 * 
 */

class ModuleFutur extends Module {
  ModuleFutur() {
    id = "f1";

    etapes = [
      EtapeFutur01(),
      EtapeFutur02(),
      EtapeFutur03(),
      EtapeFutur04(),
      EtapeFutur05(),
      EtapeFutur06(),
      EtapeFutur07(),
      EtapeFutur08(),
      EtapeFutur09(),
      EtapeFutur10(),
      EtapeFutur11(),
      EtapeFutur12(),
      EtapeFutur13(),
      EtapeFutur14(),
      EtapeFutur15(),
      EtapeFutur16(),
      EtapeFutur17(),
      EtapeFutur18(),
      EtapeFutur19(),
      EtapeFutur20(),
      EtapeFutur21(),
      EtapeFutur22()
    ];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Futur simple";
  }
}

abstract class EtapeFutur extends Etape {
  EtapeFutur() {
    temps = TempsFuturSimple();
  }
}

// Étape 1
// Apprentissage
// Avoir, être, aller
class EtapeFutur01 extends EtapeFutur {
  EtapeFutur01() {
    id = "f1_01";
    type = TypeEtape.apprentissage;
    description = '"Avoir", "être" et "aller".';
    contenu = [Avoir(), Etre(), Aller()];
  }
}

// Étape 2
// Apprentissage
// Faire, pouvoir, vouloir
class EtapeFutur02 extends EtapeFutur {
  EtapeFutur02() {
    id = "f1_02";
    type = TypeEtape.apprentissage;
    description = '"Faire", "pouvoir" et "vouloir".';
    contenu = [Faire(), Pouvoir(), Vouloir()];
  }
}

// Étape 3
// Révision
// 1 et 2
class EtapeFutur03 extends EtapeFutur {
  EtapeFutur03() {
    id = "f1_03";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 1 et 2.';
    contenu = [Avoir(), Etre(), Aller(), Faire(), Pouvoir(), Vouloir()];
  }
}

// Étape 4
// Apprentissage
// -enir -> venir, devenir, prévenir, se souvenir
class EtapeFutur04 extends EtapeFutur {
  EtapeFutur04() {
    id = "f1_04";
    type = TypeEtape.apprentissage;
    description = '"Venir", "devenir", "prévenir" et "se souvenir".';
    contenu = [Venir(), Devenir(), Prevenir(), SeSouvenir()];
  }
}

// Étape 5
// Apprentissage
// -enir -> tenir, retenir, obtenir, soutenir
class EtapeFutur05 extends EtapeFutur {
  EtapeFutur05() {
    id = "f1_05";
    type = TypeEtape.apprentissage;
    description = '"Tenir", "retenir", "obtenir" et "soutenir".';
    contenu = [Tenir(), Retenir(), Obtenir(), Soutenir()];
  }
}

// Étape 6
// Révision
// 4 et 5
class EtapeFutur06 extends EtapeFutur {
  EtapeFutur06() {
    id = "f1_06";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 4 et 5.';
    contenu = [
      Venir(),
      Devenir(),
      Prevenir(),
      SeSouvenir(),
      Tenir(),
      Retenir(),
      Obtenir(),
      Soutenir()
    ];
  }
}

// Étape 7
// Apprentissage
// Courir, parcourir, mourir
class EtapeFutur07 extends EtapeFutur {
  EtapeFutur07() {
    id = "f1_07";
    type = TypeEtape.apprentissage;
    description = '"Courir", "parcourir" et "mourir".';
    contenu = [Courir(), Parcourir(), Mourir()];
  }
}

// Étape 8
// Apprentissage
// Verbes en -evoir -> devoir, apercevoir, décevoir, recevoir
class EtapeFutur08 extends EtapeFutur {
  EtapeFutur08() {
    id = "f1_08";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -evoir.';
    contenu = [Devoir(), Apercevoir(), Decevoir(), Recevoir()];
  }
}

// Étape 9
// Révision
// 7 et 8
class EtapeFutur09 extends EtapeFutur {
  EtapeFutur09() {
    id = "f1_09";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 7 et 8.';
    contenu = [
      Courir(),
      Parcourir(),
      Mourir(),
      Devoir(),
      Apercevoir(),
      Decevoir(),
      Recevoir()
    ];
  }
}

// Étape 10
// Apprentissage
// Falloir, pleuvoir, s'asseoir
class EtapeFutur10 extends EtapeFutur {
  EtapeFutur10() {
    id = "f1_10";
    type = TypeEtape.apprentissage;
    description =
        'Verbes impersonnels : "falloir" et "pleuvoir" + "s\'asseoir".';
    contenu = [Falloir(), Pleuvoir(), SAsseoir()];
  }
}

// Étape 11
// Apprentissage
// Voir, prévoir, envoyer
class EtapeFutur11 extends EtapeFutur {
  EtapeFutur11() {
    id = "f1_11";
    type = TypeEtape.apprentissage;
    description = '"Voir", "prévoir" et "envoyer".';
    contenu = [Voir(), Prevoir(), Envoyer()];
  }
}

// Étape 12
// Révision
// 10 et 11
class EtapeFutur12 extends EtapeFutur {
  EtapeFutur12() {
    id = "f1_12";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 10 et 11.';
    contenu = [Falloir(), Pleuvoir(), Voir(), Prevoir()];
  }
}

// Étape 13
// Apprentissage
// Appeler, jeter, projeter, rejeter
class EtapeFutur13 extends EtapeFutur {
  EtapeFutur13() {
    id = "f1_13";
    type = TypeEtape.apprentissage;
    description = 'Exceptions "appeler" et "jeter".';
    contenu = [Appeler(), Jeter(), Projeter(), Rejeter()];
  }
}

// Étape 14
// Apprentissage
// E*er et é*er : acheter, geler, lever, se lever
class EtapeFutur14 extends EtapeFutur {
  EtapeFutur14() {
    id = "f1_14";
    type = TypeEtape.apprentissage;
    description = 'E*er, é*er : "acheter", "geler", "lever" et "se lever".';
    contenu = [Acheter(), Geler(), Lever(), SeLever()];
  }
}

// Étape 15
// Apprentissage
// E*er et é*er : peser, se peser, céder
class EtapeFutur15 extends EtapeFutur {
  EtapeFutur15() {
    id = "f1_15";
    type = TypeEtape.apprentissage;
    description = 'E*er, é*er : "peser", "se peser" et "céder".';
    contenu = [Peser(), SePeser(), Ceder()];
  }
}

// Étape 16
// Révision
// 13, 14, 15
class EtapeFutur16 extends EtapeFutur {
  EtapeFutur16() {
    id = "f1_16";
    type = TypeEtape.revision;
    description =
        'Révision des verbes en e*er et é*er, et de leurs exceptions.';
    contenu = [
      Appeler(),
      Jeter(),
      Projeter(),
      Rejeter(),
      Acheter(),
      Geler(),
      Lever(),
      SeLever(),
      Peser(),
      SePeser(),
      Ceder()
    ];
  }
}

// Étape 17
// Apprentissage
// Cueillir, accueillir
class EtapeFutur17 extends EtapeFutur {
  EtapeFutur17() {
    id = "f1_17";
    type = TypeEtape.apprentissage;
    description = '"Cueillir" et "accueillir".';
    contenu = [Cueillir(), Accueillir()];
  }
}

// Étape 18
// Apprentissage
// Savoir, valoir
class EtapeFutur18 extends EtapeFutur {
  EtapeFutur18() {
    id = "f1_18";
    type = TypeEtape.apprentissage;
    description = 'Derniers verbes : "savoir" et "valoir".';
    contenu = [Savoir(), Valoir()];
  }
}

// Étape 19
// Révision
// 17 et 18
class EtapeFutur19 extends EtapeFutur {
  EtapeFutur19() {
    id = "f1_19";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 17 et 18.';
    contenu = [Cueillir(), Accueillir(), Savoir(), Valoir()];
  }
}

// Étape 20
// Apprentissage
// Convenir, parvenir, revenir
class EtapeFutur20 extends EtapeFutur {
  EtapeFutur20() {
    id = "f1_20";
    type = TypeEtape.apprentissage;
    description = 'Composés de "venir" : "convenir", "parvenir" et "revenir".';
    contenu = [Convenir(), Parvenir(), Revenir()];
  }
}

// Étape 21
// Apprentissage
// Appartenir, détenir
class EtapeFutur21 extends EtapeFutur {
  EtapeFutur21() {
    id = "f1_21";
    type = TypeEtape.apprentissage;
    description = 'Composés de "tenir" : "appartenir" et "détenir".';
    contenu = [Appartenir(), Detenir()];
  }
}

// Étape 22
// Révision
// 20 et 21
class EtapeFutur22 extends EtapeFutur {
  EtapeFutur22() {
    id = "f1_22";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 20 et 21.';
    contenu = [Convenir(), Parvenir(), Revenir(), Appartenir(), Detenir()];
  }
}

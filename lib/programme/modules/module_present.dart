import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Ce module porte sur les verbes irréguliers au présent
 * Le module comprend un certain nombre d'étapes détaillées dans ce fichier.
 */

/*
 * Les verbes irréguliers présentés dans ce module sont :
 * 
 * Aller
 * Avoir
 * Dormir
 * Envoyer
 * Etre
 * Faire
 * Lire
 * Partir
 * Pouvoir
 * Prévoir
 * Savoir
 * Sortir
 * Voir
 * Vouloir
 * 
 * Devoir et similaires
 * Ecrire et composés
 * Prendre et composés
 * Verbes en -enir
 * 
 * 
 */

class ModulePresent extends Module {
  ModulePresent() {
    id = "pr1";

    // Création des étapes
    etapes = [
      EtapePresent01(),
      EtapePresent02(),
      EtapePresent03(),
      EtapePresent04(),
      EtapePresent05(),
      EtapePresent06(),
      EtapePresent07(),
      EtapePresent08(),
      EtapePresent09(),
      EtapePresent10(),
      EtapePresent11(),
      EtapePresent12(),
      EtapePresent13(),
      EtapePresent13bis(),
      EtapePresent14(),
      EtapePresent15()
    ];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Présent - Partie 1";
  }
}

// Pour éviter de préciser le temps à chaque étape
abstract class EtapePresent extends Etape {
  EtapePresent() {
    temps = TempsPresent();
  }
}

// Étape 1
// Apprentissage
// Verbes : aller, avoir, être
class EtapePresent01 extends EtapePresent {
  EtapePresent01() {
    id = "pr1_01";
    type = TypeEtape.apprentissage;
    description = 'Premiers verbes : "aller", "avoir" et "être".';
    contenu = [Aller(), Avoir(), Etre()];
  }
}

// Étape 2
// Révision
// Verbes : aller, avoir, être
class EtapePresent02 extends EtapePresent {
  EtapePresent02() {
    id = "pr1_02";
    type = TypeEtape.revision;
    description = "Révision des premiers verbes.";
    contenu = [Aller(), Avoir(), Etre()];
  }
}

// Étape 3
// Apprentissage
// Verbes : vouloir, pouvoir, faire
class EtapePresent03 extends EtapePresent {
  EtapePresent03() {
    id = "pr1_03";
    type = TypeEtape.apprentissage;
    description = '"Pouvoir", "vouloir" et "faire".';
    contenu = [Pouvoir(), Vouloir(), Faire()];
  }
}

// Étape 4
// Révision
// Verbes des étapes 1 et 3
class EtapePresent04 extends EtapePresent {
  EtapePresent04() {
    id = "pr1_04";
    type = TypeEtape.revision;
    description = 'Révision des cinq premiers verbes.';
    contenu = [Aller(), Avoir(), Etre(), Pouvoir(), Vouloir(), Faire()];
  }
}

// Étape 5
// Apprentissage
// Verbes : savoir, sortir, partir
class EtapePresent05 extends EtapePresent {
  EtapePresent05() {
    id = "pr1_05";
    type = TypeEtape.apprentissage;
    description = '"Savoir", "sortir" et "partir".';
    contenu = [Savoir(), Sortir(), Partir()];
  }
}

// Étape 6
// Révision
// Verbes des étapes 3 et 5
class EtapePresent06 extends EtapePresent {
  EtapePresent06() {
    id = "pr1_06";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 3 et 5.';
    contenu = [Pouvoir(), Vouloir(), Faire(), Savoir(), Sortir(), Partir()];
  }
}

// Étape 7
// Apprentissage
// Premiers verbes du groupe "prendre"
class EtapePresent07 extends EtapePresent {
  EtapePresent07() {
    id = "pr1_07";
    type = TypeEtape.apprentissage;
    description = '"Prendre" et ses composés.';
    contenu = [Prendre(), Apprendre(), Comprendre()];
  }
}

// Étape 8
// Révision
// Tous les verbes depuis le début sauf le groupe de "prendre"
class EtapePresent08 extends EtapePresent {
  EtapePresent08() {
    id = "pr1_08";
    type = TypeEtape.revision;
    description = 'Révision générale sans les composés de "prendre".';
    contenu = [
      Aller(),
      Avoir(),
      Etre(),
      Pouvoir(),
      Vouloir(),
      Faire(),
      Savoir(),
      Sortir(),
      Partir()
    ];
  }
}

// Étape 9
// Révision
// Groupe "prendre"
class EtapePresent09 extends EtapePresent {
  EtapePresent09() {
    id = "pr1_09";
    type = TypeEtape.revision;
    description = 'Révision des composés du verbe "prendre".';
    contenu = [Prendre(), Apprendre(), Comprendre()];
  }
}

// Étape 10
// Apprentissage
// Groupe -evoir
class EtapePresent10 extends EtapePresent {
  EtapePresent10() {
    id = "pr1_10";
    type = TypeEtape.apprentissage;
    description = '"Devoir" et autres verbes en -evoir.';
    contenu = [Devoir(), Apercevoir(), Decevoir(), Recevoir()];
  }
}

// Étape 11
// Apprentissage
// Groupe -enir
class EtapePresent11 extends EtapePresent {
  EtapePresent11() {
    id = "pr1_11";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -enir.';
    contenu = [Venir(), Devenir(), Tenir(), Retenir(), Obtenir()];
  }
}

// Étape 12
// Révision
// Groupes -evoir et -enir
class EtapePresent12 extends EtapePresent {
  EtapePresent12() {
    id = "pr1_12";
    type = TypeEtape.revision;
    description = 'Révision des verbes en -evoir et en -enir.';
    contenu = [
      Devoir(),
      Apercevoir(),
      Decevoir(),
      Recevoir(),
      Venir(),
      Devenir(),
      Tenir(),
      Retenir(),
      Obtenir()
    ];
  }
}

// Étape 13
// Apprentissage
// Lire, dormir => plus tard refaite avec la 13 bis
class EtapePresent13 extends EtapePresent {
  EtapePresent13() {
    id = "pr1_13";
    type = TypeEtape.apprentissage;
    description = '"Lire" et "dormir"';
    contenu = [Lire(), Dormir()];
  }
}

// Étape 13bis
// Apprentissage
// Voir, prévoir, envoyer
class EtapePresent13bis extends EtapePresent {
  EtapePresent13bis() {
    id = "pr1_13bis";
    type = TypeEtape.apprentissage;
    description = '"Voir", "prévoir" et "envoyer"';
    contenu = [Voir(), Prevoir(), Envoyer()];
  }
}

// Étape 14
// Apprentissage
// Groupe écrire
class EtapePresent14 extends EtapePresent {
  EtapePresent14() {
    id = "pr1_14";
    type = TypeEtape.apprentissage;
    description = '"Écrire" et ses composés.';
    contenu = [Ecrire(), Decrire(), Inscrire()];
  }
}

// Étape 15
// Révision
// Lire, dormir, voir, prévoir et groupe "écrire"
class EtapePresent15 extends EtapePresent {
  EtapePresent15() {
    id = "pr1_15";
    type = TypeEtape.revision;
    description =
        'Révision de "lire", "dormir", "voir", "prévoir" et des composés du verbe "écrire"';
    contenu = [
      Lire(),
      Dormir(),
      Voir(),
      Prevoir(),
      Ecrire(),
      Decrire(),
      Inscrire()
    ];
  }
}

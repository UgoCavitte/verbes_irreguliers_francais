import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Ce module est la suite du premier module sur le présent
 */

/*
 * Les verbes irréguliers présentés dans ce module sont :
 * 
 * Boire
 * Courir
 * Croire
 * Falloir
 * Mourir
 * Parcourir
 * Pleuvoir
 * Rire
 * Sentir
 * Sourire
 * Survivre
 * Vivre
 * 
 * Appeler/jeter
 * E*er, é*er
 * Mettre et composés
 * Dire et composés
 * Verbe en -indre
 * 
 */

class ModulePresent2 extends Module {
  ModulePresent2() {
    id = "pr2";

    // création des étapes
    etapes = [
      EtapePresentm2e01(),
      EtapePresentm2e02(),
      EtapePresentm2e03(),
      EtapePresentm2e04(),
      EtapePresentm2e05(),
      EtapePresentm2e06(),
      EtapePresentm2e07(),
      EtapePresentm2e08(),
      EtapePresentm2e09(),
      EtapePresentm2e10(),
      EtapePresentm2e11(),
      EtapePresentm2e12(),
      EtapePresentm2e13(),
      EtapePresentm2e14(),
      EtapePresentm2e15(),
      EtapePresentm2e16()
    ];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = "Présent - Partie 2";
  }
}

// Étape 1
// Apprentissage
// Mettre et composés (- transmettre)
class EtapePresentm2e01 extends EtapePresent {
  EtapePresentm2e01() {
    id = "pr2_01";
    type = TypeEtape.apprentissage;
    description = '"Mettre" et ses composés.';
    contenu = [Mettre(), Permettre(), Promettre()];
  }
}

// Étape 2
// Apprentissage
// Dire et ses composés (- prédire)
class EtapePresentm2e02 extends EtapePresent {
  EtapePresentm2e02() {
    id = "pr2_02";
    type = TypeEtape.apprentissage;
    description = '"Dire" et ses composés.';
    contenu = [Dire(), Redire(), Interdire()];
  }
}

// Étape 3
// Révision
// Révisions des verbes des étapes 1 et 2
class EtapePresentm2e03 extends EtapePresent {
  EtapePresentm2e03() {
    id = "pr2_03";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 1 et 2.';
    contenu = [
      Mettre(),
      Permettre(),
      Promettre(),
      Dire(),
      Redire(),
      Interdire()
    ];
  }
}

// Étape 4
// Apprentissage
// Boire, sentir, vivre, survivre
class EtapePresentm2e04 extends EtapePresent {
  EtapePresentm2e04() {
    id = "pr2_04";
    type = TypeEtape.apprentissage;
    description = '"Boire", "sentir", "vivre" et "survivre".';
    contenu = [Boire(), Sentir(), Vivre(), Survivre()];
  }
}

// Étape 5
// Apprentissage
// Croire, rire, sourire
class EtapePresentm2e05 extends EtapePresent {
  EtapePresentm2e05() {
    id = "pr2_05";
    type = TypeEtape.apprentissage;
    description = '"Croire", "rire" et "sourire".';
    contenu = [Croire(), Rire(), Sourire()];
  }
}

// Étape 6
// Révision
// 4 et 5
class EtapePresentm2e06 extends EtapePresent {
  EtapePresentm2e06() {
    id = "pr2_06";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 4 et 5.';
    contenu = [
      Boire(),
      Sentir(),
      Vivre(),
      Survivre(),
      Croire(),
      Rire(),
      Sourire()
    ];
  }
}

// Étape 7
// Apprentissage
// Appeler, jeter
class EtapePresentm2e07 extends EtapePresent {
  EtapePresentm2e07() {
    id = "pr2_07";
    type = TypeEtape.apprentissage;
    description = 'Verbes "appeler" et "jeter".';
    contenu = [Appeler(), Jeter()];
  }
}

// Étape 8
// Apprentissage
// E*er, é*er
class EtapePresentm2e08 extends EtapePresent {
  EtapePresentm2e08() {
    id = "pr2_08";
    type = TypeEtape.apprentissage;
    description = 'Autres verbes en e*er et é*er.';
    contenu = [Acheter(), SeLever(), SePeser(), Ceder()];
  }
}

// Étape 9
// Révision
// 8 et 9
class EtapePresentm2e09 extends EtapePresent {
  EtapePresentm2e09() {
    id = "pr2_09";
    type = TypeEtape.revision;
    description =
        'Révision des verbes "appeler" et "jeter" et des autres verbes en e*er et é*er.';
    contenu = [Appeler(), Jeter(), Acheter(), SeLever(), SePeser(), Ceder()];
  }
}

// Étape 10
// Révision générale
// 1, 2, 4, 5, 7 et 8
class EtapePresentm2e10 extends EtapePresent {
  EtapePresentm2e10() {
    id = "pr2_10";
    type = TypeEtape.revision;
    description = 'Révision de tous les verbes depuis le début de cette étape.';
    contenu = [
      Mettre(),
      Permettre(),
      Promettre(),
      Dire(),
      Redire(),
      Interdire(),
      Boire(),
      Sentir(),
      Vivre(),
      Survivre(),
      Croire(),
      Rire(),
      Sourire(),
      Appeler(),
      Jeter(),
      Acheter(),
      SeLever(),
      SePeser(),
      Ceder()
    ];
  }
}

// Étape 11
// Apprentissage
// Falloir, pleuvoir
class EtapePresentm2e11 extends EtapePresent {
  EtapePresentm2e11() {
    id = "pr2_11";
    type = TypeEtape.apprentissage;
    description = 'Verbes impersonnels "falloir" et "pleuvoir".';
    contenu = [Falloir(), Pleuvoir()];
  }
}

// Étape 12
// Apprentissage
// Courir, parcourir, mourir
class EtapePresentm2e12 extends EtapePresent {
  EtapePresentm2e12() {
    id = "pr2_12";
    type = TypeEtape.apprentissage;
    description = '"Courir", "parcourir" et "mourir".';
    contenu = [Courir(), Parcourir(), Mourir()];
  }
}

// Étape 13
// Révision
// 11 et 12
class EtapePresentm2e13 extends EtapePresent {
  EtapePresentm2e13() {
    id = "pr2_13";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 11 et 12.';
    contenu = [Falloir(), Pleuvoir(), Courir(), Parcourir(), Mourir()];
  }
}

// Étape 14
// Apprentissage
// Verbes en -indre -> atteindre, éteindre, peindre, craindre
class EtapePresentm2e14 extends EtapePresent {
  EtapePresentm2e14() {
    id = "pr2_14";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -indre. Partie 1.';
    contenu = [Atteindre(), Eteindre(), Peindre(), Craindre()];
  }
}

// Étape 15
// Apprentissage
// Verbes en -indre -> joindre, rejoindre, plaindre, se plaindre
class EtapePresentm2e15 extends EtapePresent {
  EtapePresentm2e15() {
    id = "pr2_15";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -indre. Partie 2.';
    contenu = [Joindre(), Rejoindre(), Plaindre(), SePlaindre()];
  }
}

// Étape 16
// Révision
// Verbes en -indre
class EtapePresentm2e16 extends EtapePresent {
  EtapePresentm2e16() {
    id = "pr2_16";
    type = TypeEtape.revision;
    description = 'Révision des verbes en -indre.';
    contenu = [
      Atteindre(),
      Eteindre(),
      Peindre(),
      Craindre(),
      Joindre(),
      Rejoindre(),
      Plaindre(),
      SePlaindre()
    ];
  }
}

// Étape 17
// Révision générale

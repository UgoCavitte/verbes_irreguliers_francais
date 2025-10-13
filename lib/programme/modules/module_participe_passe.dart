import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/data/verbes.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

/*
 * Ce module concerne les participes passés
 * Il vaut sûrement mieux diviser cette partie en différents modules
 * 
 * Les utilisateurs commencent ce module quand ils commencent le passé composé,
 * mais l'application leur demande uniquement le participe passé
 * 
 * 
 * 
 * Verbes vus dans ce module :
 * 
 * Accueillir, cueillir
 * Avoir
 * Battre
 * Boire
 * Conclure
 * Croire
 * Courir, parcourir
 * Dormir
 * Envoyer
 * Être
 * Faire
 * Falloir
 * Lire
 * Mourir
 * Naître
 * Plaire
 * Pleuvoir
 * Pouvoir
 * Prévoir, voir
 * Rire, sourire
 * Savoir
 * Sentir
 * Servir
 * Sortir
 * Suffire
 * Se taire
 * Vaincre, convaincre
 * Valoir
 * Vivre, survivre
 * Vouloir
 * 
 * # écrire :
 * Écrire : décrire, réécrire
 * Inscrire
 * 
 * # dire :
 * Dire, redire, interdire, prédire
 * 
 *  * # -enir :
 * Tenir : appartenir, détenir, obtenir, retenir, soutenir
 * Venir : convenir, devenir, parvenir, prévenir, revenir, se souvenir
 * 
 * # -evoir :
 * Apercevoir, décevoir, recevoir
 * Devoir
 * 
 * # -oudre :
 * Coudre
 * Moudre
 * Résoudre
 * 
 * # prendre :
 * Apprendre
 * Comprendre
 * Prendre
 * Surprendre
 * 
 * # mettre :
 * Mettre
 * Permettre
 * Promettre
 * Transmettre
 * 
 * # -indre
 * Atteindre
 * Craindre
 * Éteindre
 * Joindre, rejoindre
 * Peindre
 * Plaindre, se plaindre
 * 
 * # -uire :
 * -duire : conduire, déduire, introduire, produire, réduire, séduire, traduire
 * Construire, détruire
 * Cuire
 * Luire
 * Nuire
 * 
 * Ajouts tardifs :
 * S'asseoir
 * 
 */

class ModuleParticipePasse extends Module {
  ModuleParticipePasse() {
    id = "ppa1";

    // Création des étapes
    etapes = [
      EtapeParticipePasse01(),
      EtapeParticipePasse02(),
      EtapeParticipePasse03(),
      EtapeParticipePasse04(),
      EtapeParticipePasse05(),
      EtapeParticipePasse06(),
      EtapeParticipePasse07(),
      EtapeParticipePasse08(),
      EtapeParticipePasse09(),
      EtapeParticipePasse10(),
      EtapeParticipePasse11(),
      EtapeParticipePasse12(),
      EtapeParticipePasse13(),
      EtapeParticipePasse14(),
      EtapeParticipePasse15(),
      EtapeParticipePasse16(),
      EtapeParticipePasse17(),
      EtapeParticipePasse18()
    ];

    // Numérotation des étapes
    numeroterEtapes();

    // Création de la description
    description = 'Participe passé';
  }
}

abstract class EtapeParticipePasse extends Etape {
  EtapeParticipePasse() {
    temps = TempsParticipePasse();
  }
}

// Étape 1
// Apprentissage
// Avoir, être, faire, lire, pouvoir, vouloir
class EtapeParticipePasse01 extends EtapeParticipePasse {
  EtapeParticipePasse01() {
    id = "ppa1_01";
    type = TypeEtape.apprentissage;
    description =
        'Premiers verbes : "avoir", "être", "faire", "lire", "pouvoir" et "vouloir".';
    contenu = [Avoir(), Etre(), Faire(), Lire(), Pouvoir(), Vouloir()];
  }
}

// Étape 2
// Apprentissage
// Écrire, décrire, réécrire, inscrire
class EtapeParticipePasse02 extends EtapeParticipePasse {
  EtapeParticipePasse02() {
    id = "ppa1_02";
    type = TypeEtape.apprentissage;
    description =
        '"Écrire" et ses composés : "décrire", "réécrire" et "inscrire".';
    contenu = [Ecrire(), Decrire(), Reecrire(), Inscrire()];
  }
}

// Étape 3
// Apprentissage
// Dire, redire, interdire, prédire
class EtapeParticipePasse03 extends EtapeParticipePasse {
  EtapeParticipePasse03() {
    id = "ppa1_03";
    type = TypeEtape.apprentissage;
    description =
        '"Dire" et ses composés : "redire", "interdire", "prédire" et "maudire".';
    contenu = [Dire(), Redire(), Interdire(), Predire(), Maudire()];
  }
}

// Étape 4
// Révision
// 1, 2, 3
class EtapeParticipePasse04 extends EtapeParticipePasse {
  EtapeParticipePasse04() {
    id = "ppa1_04";
    type = TypeEtape.revision;
    description = 'Révision des verbes des trois premières étapes.';
    contenu = [
      Avoir(),
      Etre(),
      Faire(),
      Lire(),
      Pouvoir(),
      Vouloir(),
      Ecrire(),
      Decrire(),
      Reecrire(),
      Inscrire(),
      Dire(),
      Redire(),
      Interdire(),
      Predire()
    ];
  }
}

// Étape 5
// Apprentissage
// -ir -i
class EtapeParticipePasse05 extends EtapeParticipePasse {
  EtapeParticipePasse05() {
    id = "ppa1_05";
    type = TypeEtape.apprentissage;
    description =
        'Verbes en -ir(e) avec un participe passé en -i : "cueillir", "accueillir", "dormir", "rire", "sourire", "sentir", "servir", "sortir", "suffire".';
    contenu = [
      Cueillir(),
      Accueillir(),
      Dormir(),
      Rire(),
      Sourire(),
      Sentir(),
      Servir(),
      Sortir(),
      Suffire()
    ];
  }
}

// Étape 6
// Apprentissage
// -ir -u
class EtapeParticipePasse06 extends EtapeParticipePasse {
  EtapeParticipePasse06() {
    id = "ppa1_06";
    type = TypeEtape.apprentissage;
    description =
        'Verbes en -ir(e) avec un participe passé en -u : "courir", "parcourir", "tenir", "appartenir", "détenir", "obtenir", "retenir", "soutenir".';
    contenu = [
      Courir(),
      Parcourir(),
      Tenir(),
      Appartenir(),
      Detenir(),
      Obtenir(),
      Retenir(),
      Soutenir()
    ];
  }
}

// Étape 7
// Apprentissage
// -ir (-venir) -u
class EtapeParticipePasse07 extends EtapeParticipePasse {
  EtapeParticipePasse07() {
    id = "ppa1_07";
    type = TypeEtape.apprentissage;
    description =
        'Encore des verbes en -ir(e) avec un participe passé en -u : "venir", "convenir", "devenir", "parvenir", "prévenir", "revenir", "se souvenir".';
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

// Étape 8
// Révision
// 5, 6, 7
class EtapeParticipePasse08 extends EtapeParticipePasse {
  EtapeParticipePasse08() {
    id = "ppa1_08";
    type = TypeEtape.revision;
    description = 'Révision des verbes en -ir(e).';
    contenu = [
      Cueillir(),
      Accueillir(),
      Dormir(),
      Rire(),
      Sourire(),
      Sentir(),
      Servir(),
      Sortir(),
      Suffire(),
      Courir(),
      Parcourir(),
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

// Étape 9
// Apprentissage
// -oir(e) -u
class EtapeParticipePasse09 extends EtapeParticipePasse {
  EtapeParticipePasse09() {
    id = "ppa1_09";
    type = TypeEtape.apprentissage;
    description =
        'Verbes en -oir(e) avec un participe passé en -u : "boire"; "croire", "falloir", "pleuvoir", "prévoir", "voir", "envoyer", "savoir" et "valoir".';
    contenu = [
      Boire(),
      Croire(),
      Falloir(),
      Pleuvoir(),
      Prevoir(),
      Voir(),
      Envoyer(),
      Savoir(),
      Valoir()
    ];
  }
}

// Étape 10
// Apprentissage
// -evoir
class EtapeParticipePasse10 extends EtapeParticipePasse {
  EtapeParticipePasse10() {
    id = "ppa1_10";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -evoir et en -oudre : participe passé en -u.';
    contenu = [
      Devoir(),
      Apercevoir(),
      Decevoir(),
      Recevoir(),
      Coudre(),
      Moudre(),
      Resoudre()
    ];
  }
}

// Étape 11
// Apprentissage
// -u
class EtapeParticipePasse11 extends EtapeParticipePasse {
  EtapeParticipePasse11() {
    id = "ppa1_11";
    type = TypeEtape.apprentissage;
    description =
        'Encore quelques participes passés en -u : "battre", "conclure", "vaincre", "convaincre", "plaire", "vivre", "survivre", et "se taire".';
    contenu = [
      Battre(),
      Conclure(),
      Vaincre(),
      Convaincre(),
      Plaire(),
      Vivre(),
      Survivre(),
      SeTaire()
    ];
  }
}

// Étape 12
// Révision
// 9 10 11
class EtapeParticipePasse12 extends EtapeParticipePasse {
  EtapeParticipePasse12() {
    id = "ppa1_12";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 9, 10 et 11.';
    contenu = [
      Boire(),
      Croire(),
      Falloir(),
      Pleuvoir(),
      Prevoir(),
      Voir(),
      Savoir(),
      Valoir(),
      Devoir(),
      Apercevoir(),
      Decevoir(),
      Recevoir(),
      Coudre(),
      Moudre(),
      Resoudre(),
      Battre(),
      Conclure(),
      Vaincre(),
      Convaincre(),
      Plaire(),
      Vivre(),
      Survivre(),
      SeTaire()
    ];
  }
}

// Étape 13
// Apprentissage
// -mettre et -prendre
class EtapeParticipePasse13 extends EtapeParticipePasse {
  EtapeParticipePasse13() {
    id = "ppa1_13";
    type = TypeEtape.apprentissage;
    description =
        'Composés de "mettre" et de "prendre" : participe passé en -is.';
    contenu = [
      Mettre(),
      Permettre(),
      Promettre(),
      Transmettre(),
      Prendre(),
      Apprendre(),
      Comprendre(),
      Surprendre()
    ];
  }
}

// Étape 14
// Apprentissage
// -indre
class EtapeParticipePasse14 extends EtapeParticipePasse {
  EtapeParticipePasse14() {
    id = "ppa1_14";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -indre : participe passé en -int.';
    contenu = [
      Atteindre(),
      Craindre(),
      Eteindre(),
      Joindre(),
      Rejoindre(),
      Peindre(),
      Plaindre(),
      SePlaindre()
    ];
  }
}

// Étape 15
// Révision
// 13 14
class EtapeParticipePasse15 extends EtapeParticipePasse {
  EtapeParticipePasse15() {
    id = "ppa1_15";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 13 et 14.';
    contenu = [
      Mettre(),
      Permettre(),
      Promettre(),
      Transmettre(),
      Prendre(),
      Apprendre(),
      Comprendre(),
      Surprendre(),
      Atteindre(),
      Craindre(),
      Eteindre(),
      Joindre(),
      Rejoindre(),
      Peindre(),
      Plaindre(),
      SePlaindre()
    ];
  }
}

// Étape 16
// Apprentissage
// Mourir, naître, s'asseoir
class EtapeParticipePasse16 extends EtapeParticipePasse {
  EtapeParticipePasse16() {
    id = "ppa1_16";
    type = TypeEtape.apprentissage;
    description = 'Petites exceptions : "naître", "mourir" et "s\'asseoir".';
    contenu = [Mourir(), Naitre(), SAsseoir()];
  }
}

// Étape 17
// Apprentissage
// -uire
class EtapeParticipePasse17 extends EtapeParticipePasse {
  EtapeParticipePasse17() {
    id = "ppa1_17";
    type = TypeEtape.apprentissage;
    description = 'Verbes en -uire : participe passé en -uit.';
    contenu = [
      Conduire(),
      Deduire(),
      Introduire(),
      Produire(),
      Reduire(),
      Seduire(),
      Traduire(),
      Construire(),
      Detruire(),
      Cuire(),
      Luire(),
      Nuire()
    ];
  }
}

// Étape 18
// Révision
// 16 17
class EtapeParticipePasse18 extends EtapeParticipePasse {
  EtapeParticipePasse18() {
    id = "ppa1_18";
    type = TypeEtape.revision;
    description = 'Révision des verbes des étapes 16 et 17.';
    contenu = [
      Mourir(),
      Naitre(),
      Conduire(),
      Deduire(),
      Introduire(),
      Produire(),
      Reduire(),
      Seduire(),
      Traduire(),
      Construire(),
      Detruire(),
      Cuire(),
      Luire(),
      Nuire()
    ];
  }
}

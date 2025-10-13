import 'package:verbes_irreguliers_francais/data/constantes.dart';

import '../types/types_verbes.dart';
import 'sous_groupes.dart';
import 'temps.dart';

// Verbes en e*er et é*er
final class Acheter extends Verbe {
  Acheter() {
    infinitif = "Acheter";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["achète", "achètes", "achète", "achetons", "achetez", "achètent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "achèterai",
        "achèteras",
        "achètera",
        "achèterons",
        "achèterez",
        "achèteront"
      ]
    ];
  }
}

final class Lever extends Verbe {
  Lever() {
    infinitif = "Lever";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["lève", "lèves", "lève", "levons", "levez", "lèvent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["lèverai", "lèveras", "lèvera", "lèverons", "lèverez", "lèveront"]
    ];
  }
}

final class SeLever extends Verbe {
  SeLever() {
    infinitif = "Se lever";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "me lève",
        "te lèves",
        "se lève",
        "nous levons",
        "vous levez",
        "se lèvent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "me lèverai",
        "te lèveras",
        "se lèvera",
        "nous lèverons",
        "vous lèverez",
        "se lèveront"
      ]
    ];
  }
}

final class Peser extends Verbe {
  Peser() {
    infinitif = "Peser";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["pèse", "pèses", "pèse", "pesons", "pesez", "pèsent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["pèserai", "pèseras", "pèsera", "pèserons", "pèserez", "pèseront"]
    ];
  }
}

final class SePeser extends Verbe {
  SePeser() {
    infinitif = "Se peser";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "me pèse",
        "te pèses",
        "se pèse",
        "nous pesons",
        "vous pesez",
        "se pèsent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "me pèserai",
        "te pèseras",
        "se pèsera",
        "nous pèserons",
        "vous pèserez",
        "se pèseront"
      ]
    ];
  }
}

final class Geler extends Verbe {
  Geler() {
    infinitif = "Geler";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["gèle", "gèles", "gèle", "gelons", "gelez", "gèlent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["gèlerai", "gèleras", "gèlera", "gèlerons", "gèlerez", "gèleront"]
    ];
  }
}

final class Ceder extends Verbe {
  Ceder() {
    infinitif = "Céder";
    sousGroupe = SousGroupeEER();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["cède", "cèdes", "cède", "cédons", "cédez", "cèdent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "céderai / cèderai",
        "céderas / cèderas",
        "cédera / cèdera",
        "céderons / cèderons",
        "céderez / cèderez",
        "céderont / cèderont"
      ]
    ];
  }
}

// Exceptions e*er é*er
final class Appeler extends Verbe {
  Appeler() {
    infinitif = "Appeler";
    sousGroupe = SousGroupeAppelerJeter();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["appelle", "appelles", "appelle", "appelons", "appelez", "appellent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "appellerai",
        "appelleras",
        "appellera",
        "appellerons",
        "appellerez",
        "appelleront"
      ]
    ];
  }
}

final class Jeter extends Verbe {
  Jeter() {
    infinitif = "Jeter";
    sousGroupe = SousGroupeAppelerJeter();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["jette", "jettes", "jette", "jetons", "jetez", "jettent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["jetterai", "jetteras", "jettera", "jetterons", "jetterez", "jetteront"]
    ];
  }
}

final class Rejeter extends Verbe {
  Rejeter() {
    infinitif = "Rejeter";
    sousGroupe = SousGroupeAppelerJeter();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["rejette", "rejettes", "rejette", "rejetons", "rejetez", "rejettent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "rejetterai",
        "rejetteras",
        "rejettera",
        "rejetterons",
        "rejetterez",
        "rejetteront"
      ]
    ];
  }
}

final class Projeter extends Verbe {
  Projeter() {
    infinitif = "Projeter";
    sousGroupe = SousGroupeAppelerJeter();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "projette",
        "projettes",
        "projette",
        "projetons",
        "projetez",
        "projettent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "projetterai",
        "projetteras",
        "projettera",
        "projetterons",
        "projetterez",
        "projetteront"
      ]
    ];
  }
}

// Verbes en -evoir
final class Devoir extends Verbe {
  Devoir() {
    infinitif = "Devoir";
    sousGroupe = SousGroupeEvoir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["dois", "dois", "doit", "devons", "devez", "doivent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["devrai", "devras", "devra", "devrons", "devrez", "devront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["doive", "doives", "doive", "devions", "deviez", "doivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["dû"]
    ];
  }
}

final class Recevoir extends Verbe {
  Recevoir() {
    infinitif = "Recevoir";
    sousGroupe = SousGroupeEvoir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["reçois", "reçois", "reçoit", "recevons", "recevez", "reçoivent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["recevrai", "recevras", "recevra", "recevrons", "recevrez", "recevront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["reçoive", "reçoives", "reçoive", "recevions", "receviez", "reçoivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["reçu"]
    ];
  }
}

final class Decevoir extends Verbe {
  Decevoir() {
    infinitif = "Décevoir";
    sousGroupe = SousGroupeEvoir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["déçois", "déçois", "déçoit", "décevons", "décevez", "déçoivent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["décevrai", "décevras", "décevra", "décevrons", "décevrez", "décevront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["déçoive", "déçoives", "déçoive", "décevions", "déceviez", "déçoivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["déçu"]
    ];
  }
}

final class Apercevoir extends Verbe {
  Apercevoir() {
    infinitif = "Apercevoir";
    sousGroupe = SousGroupeEvoir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      [
        "aperçois",
        "aperçois",
        "aperçoit",
        "apercevons",
        "apercevez",
        "aperçoivent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "apercevrai",
        "apercevras",
        "apercevra",
        "apercevrons",
        "apercevrez",
        "aperçoivent"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      [
        "aperçoive",
        "aperçoives",
        "aperçoive",
        "apercevions",
        "aperceviez",
        "aperçoivent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["aperçu"]
    ];
  }
}

final class Tenir extends Verbe {
  Tenir() {
    infinitif = "Tenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["tiens", "tiens", "tient", "tenons", "tenez", "tiennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["tiendrai", "tiendras", "tiendra", "tiendrons", "tiendrez", "tiendront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["tienne", "tiennes", "tienne", "tenions", "teniez", "tiennent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["tenu"]
    ];
  }
}

final class Appartenir extends Verbe {
  Appartenir() {
    infinitif = "Appartenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      [
        "appartiens",
        "appartiens",
        "appartient",
        "appartenons",
        "appartenez",
        "appartiennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "appartiendrai",
        "appartiendras",
        "appartiendra",
        "appartiendrons",
        "appartiendrez",
        "appartiendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      [
        "appartienne",
        "appartiennes",
        "appartienne",
        "appartenions",
        "apparteniez",
        "appartiennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["appartenu"]
    ];
  }
}

final class Retenir extends Verbe {
  Retenir() {
    infinitif = "Retenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["retiens", "retiens", "retient", "retenons", "retenez", "retiennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "retiendrai",
        "retiendras",
        "retiendra",
        "retiendrons",
        "retiendrez",
        "retiendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "retienne",
        "retiennes",
        "retienne",
        "retenions",
        "reteniez",
        "retiennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["retenu"]
    ];
  }
}

final class Detenir extends Verbe {
  Detenir() {
    infinitif = "Détenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["détiens", "détiens", "détient", "détenons", "détenez", "détiennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "détiendrai",
        "détiendras",
        "détiendra",
        "détiendrons",
        "détiendrez",
        "détiendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "détienne",
        "détiennes",
        "détienne",
        "détenions",
        "déteniez",
        "détiennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["détenu"]
    ];
  }
}

final class Obtenir extends Verbe {
  Obtenir() {
    infinitif = "Obtenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["obtiens", "obtiens", "obtient", "obtenons", "obtenez", "obtiennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "obtiendrai",
        "obtiendras",
        "obtiendra",
        "obtiendrons",
        "obtiendrez",
        "obtiendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      [
        "obtienne",
        "obtiennes",
        "obtienne",
        "obtenions",
        "obteniez",
        "obtiennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["obtenu"]
    ];
  }
}

final class Soutenir extends Verbe {
  Soutenir() {
    infinitif = "Soutenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "soutiens",
        "soutiens",
        "soutient",
        "soutenons",
        "soutenez",
        "soutiennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "soutiendrai",
        "soutiendras",
        "soutiendra",
        "soutiendrons",
        "soutiendrez",
        "soutiendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "soutienne",
        "soutiennes",
        "soutienne",
        "soutenions",
        "souteniez",
        "soutiennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["soutenu"]
    ];
  }
}

final class Venir extends Verbe {
  Venir() {
    infinitif = "Venir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["viens", "viens", "vient", "venons", "venez", "viennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["viendrai", "viendras", "viendra", "viendrons", "viendrez", "viendront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["vienne", "viennes", "vienne", "venions", "veniez", "viennent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["venu"]
    ];
  }
}

final class Convenir extends Verbe {
  Convenir() {
    infinitif = "Convenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "conviens",
        "conviens",
        "convient",
        "convenons",
        "convenez",
        "conviennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "conviendrai",
        "conviendras",
        "conviendra",
        "conviendrons",
        "conviendrez",
        "conviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "convienne",
        "conviennes",
        "convienne",
        "convenions",
        "conveniez",
        "conviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["convenu"]
    ];
  }
}

final class Devenir extends Verbe {
  Devenir() {
    infinitif = "Devenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["deviens", "deviens", "devient", "devenons", "devenez", "deviennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "deviendrai",
        "deviendras",
        "deviendra",
        "deviendrons",
        "deviendrez",
        "deviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "devienne",
        "deviennes",
        "devienne",
        "devenions",
        "deveniez",
        "deviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["devenu"]
    ];
  }
}

final class Prevenir extends Verbe {
  Prevenir() {
    infinitif = "Prévenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "préviens",
        "préviens",
        "prévient",
        "prévenons",
        "prévenez",
        "préviennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "préviendrai",
        "préviendras",
        "préviendra",
        "préviendrons",
        "préviendrez",
        "préviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "prévienne",
        "préviennes",
        "prévienne",
        "prévenions",
        "préveniez",
        "préviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["prévenu"]
    ];
  }
}

final class Revenir extends Verbe {
  Revenir() {
    infinitif = "Revenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["reviens", "reviens", "revient", "revenons", "revenez", "reviennent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "reviendrai",
        "reviendras",
        "reviendra",
        "reviendrons",
        "reviendrez",
        "reviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "revienne",
        "reviennes",
        "revienne",
        "revenions",
        "reveniez",
        "reviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["revenu"]
    ];
  }
}

final class Parvenir extends Verbe {
  Parvenir() {
    infinitif = "Parvenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "parviens",
        "parviens",
        "parvient",
        "parvenons",
        "parvenez",
        "parviennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "parviendrai",
        "parviendras",
        "parviendra",
        "parviendrons",
        "parviendrez",
        "parviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "parvienne",
        "parviennes",
        "parvienne",
        "parvenions",
        "parveniez",
        "parviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["parvenu"]
    ];
  }
}

final class Survenir extends Verbe {
  Survenir() {
    infinitif = "Survenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "surviens",
        "surviens",
        "survient",
        "survenons",
        "survenez",
        "surviennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "surviendrai",
        "surviendras",
        "surviendra",
        "surviendrons",
        "surviendrez",
        "surviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "survienne",
        "surviennes",
        "survienne",
        "survenions",
        "surveniez",
        "surviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["survenu"]
    ];
  }
}

final class SeSouvenir extends Verbe {
  SeSouvenir() {
    infinitif = "Se souvenir";
    sousGroupe = SousGroupeEnir();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "me souviens",
        "te souviens",
        "se souvient",
        "nous souvenons",
        "vous souvenez",
        "se souviennent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "me souviendrai",
        "te souviendras",
        "se souviendra",
        "nous souviendrons",
        "vous souviendrez",
        "se souviendront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "me souvienne",
        "te souviennes",
        "se souvienne",
        "nous souvenions",
        "vous souveniez",
        "se souviennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["souvenu"]
    ];
  }
}

// Verbes en -indre
final class Peindre extends Verbe {
  Peindre() {
    infinitif = "Peindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["peins", "peins", "peint", "peignons", "peignez", "peignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["peint"]
    ];
  }
}

final class Craindre extends Verbe {
  Craindre() {
    infinitif = "Craindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["crains", "crains", "craint", "craignons", "craignez", "craignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["craint"]
    ];
  }
}

final class SePlaindre extends Verbe {
  SePlaindre() {
    infinitif = "Se plaindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "me plains",
        "te plains",
        "se plaint",
        "nous plaignons",
        "vous plaignez",
        "se plaignent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["plaint"]
    ];
  }
}

final class Plaindre extends Verbe {
  Plaindre() {
    infinitif = "Plaindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["plains", "plains", "plaint", "plaignons", "plaignez", "plaignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["plaint"]
    ];
  }
}

final class Eteindre extends Verbe {
  Eteindre() {
    infinitif = "Éteindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["éteins", "éteins", "éteint", "éteignons", "éteignez", "éteignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["éteint"]
    ];
  }
}

final class Joindre extends Verbe {
  Joindre() {
    infinitif = "Joindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["joins", "joins", "joint", "joignons", "joignez", "joignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["joint"]
    ];
  }
}

final class Rejoindre extends Verbe {
  Rejoindre() {
    infinitif = "Rejoindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["rejoins", "rejoins", "rejoint", "rejoignons", "rejoignez", "rejoignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["rejoint"]
    ];
  }
}

final class Atteindre extends Verbe {
  Atteindre() {
    infinitif = "Atteindre";
    sousGroupe = SousGroupeIndre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["atteins", "atteins", "atteint", "atteignons", "atteignez", "atteignent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["atteint"]
    ];
  }
}

// Verbes en -oudre
final class Coudre extends Verbe {
  Coudre() {
    infinitif = "Coudre";
    sousGroupe = SousGroupeOudre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["couds", "couds", "coud", "cousons", "cousez", "cousent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["cousu"]
    ];
  }
}

final class Moudre extends Verbe {
  Moudre() {
    infinitif = "Moudre";
    sousGroupe = SousGroupeOudre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["mouds", "mouds", "moud", "moulons", "moulez", "moulent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["moulu"]
    ];
  }
}

// Verbes en -uire
final class Conduire extends Verbe {
  Conduire() {
    infinitif = "Conduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["conduis", "conduis", "conduit", "conduisons", "conduisez", "conduisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["conduit"]
    ];
  }
}

final class Cuire extends Verbe {
  Cuire() {
    infinitif = "Cuire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["cuis", "cuis", "cuit", "cuisons", "cuisez", "cuisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["cuit"]
    ];
  }
}

final class Nuire extends Verbe {
  Nuire() {
    infinitif = "Nuire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["nuis", "nuis", "nuit", "nuisons", "nuisez", "nuisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["nuit"]
    ];
  }
}

final class Luire extends Verbe {
  Luire() {
    infinitif = "Luire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["luis", "luis", "luit", "luisons", "luisez", "luisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["luit"]
    ];
  }
}

final class Deduire extends Verbe {
  Deduire() {
    infinitif = "Déduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["déduis", "déduis", "déduit", "déduisons", "déduisez", "déduisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["déduit"]
    ];
  }
}

final class Reduire extends Verbe {
  Reduire() {
    infinitif = "Réduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["réduis", "réduis", "réduit", "réduisons", "réduisez", "réduisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["réduit"]
    ];
  }
}

final class Detruire extends Verbe {
  Detruire() {
    infinitif = "Détruire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["détruis", "détruis", "détruit", "détruisons", "détruisez", "détruisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["détruit"]
    ];
  }
}

final class Produire extends Verbe {
  Produire() {
    infinitif = "Produire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["produis", "produis", "produit", "produisons", "produisez", "produisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["produit"]
    ];
  }
}

final class Traduire extends Verbe {
  Traduire() {
    infinitif = "Traduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["traduis", "traduis", "traduit", "traduisons", "traduisez", "traduisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["traduit"]
    ];
  }
}

final class Construire extends Verbe {
  Construire() {
    infinitif = "Construire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "construis",
        "construis",
        "construit",
        "construisons",
        "construisez",
        "construisent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["construit"]
    ];
  }
}

final class Introduire extends Verbe {
  Introduire() {
    infinitif = "Introduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      [
        "introduis",
        "introduis",
        "introduit",
        "introduisons",
        "introduisez",
        "introduisent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["introduit"]
    ];
  }
}

final class Seduire extends Verbe {
  Seduire() {
    infinitif = "Séduire";
    sousGroupe = SousGroupeUire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["séduis", "séduis", "séduit", "séduisons", "séduisez", "séduisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["séduit"]
    ];
  }
}

// Verbes très irréguliers
final class Etre extends Verbe {
  Etre() {
    infinitif = "Être";
    sousGroupe = SousGroupeAucun();

    // Set le modèle
    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["suis", "es", "est", "sommes", "êtes", "sont"]
    ];

    modele.formes[TempsImparfait()] = [
      pronomsPersonnelsVoyelle,
      ["étais", "étais", "était", "étions", "étiez", "étaient"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["serai", "seras", "sera", "serons", "serez", "seront"]
    ];

    modele.formes[TempsImperatif()] = [
      pronomsPersonnelsImperatif,
      ["sois", "soyons", "soyez"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["sois", "sois", "soit", "soyons", "soyez", "soient"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["été"]
    ];

    modele.formes[TempsParticipePresent()] = [
      pronomsPersonnelsParticipes,
      ["étant"]
    ];
  }
}

final class Avoir extends Verbe {
  Avoir() {
    infinitif = "Avoir";
    sousGroupe = SousGroupeAucun();

    // Set le modèle

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["ai", "as", "a", "avons", "avez", "ont"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      ["aurai", "auras", "aura", "aurons", "aurez", "auront"]
    ];

    modele.formes[TempsImperatif()] = [
      pronomsPersonnelsImperatif,
      ["aie", "ayons", "ayez"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      ["aie", "aies", "ait", "ayons", "ayez", "aient"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["eu"]
    ];

    modele.formes[TempsParticipePresent()] = [
      pronomsPersonnelsParticipes,
      ["ayant"]
    ];
  }
}

final class Aller extends Verbe {
  Aller() {
    infinitif = "Aller";
    sousGroupe = SousGroupeAucun();

    // Set le modèle

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["vais", "vas", "va", "allons", "allez", "vont"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      ["irai", "iras", "ira", "irons", "irez", "iront"]
    ];

    modele.formes[TempsImperatif()] = [
      pronomsPersonnelsImperatif,
      ["va", "allons", "allez"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      ["aille", "ailles", "aille", "allions", "alliez", "aillent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["allé"]
    ];
  }
}

final class Vouloir extends Verbe {
  Vouloir() {
    infinitif = "Vouloir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["veux", "veux", "veut", "voulons", "voulez", "veulent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["voudrai", "voudras", "voudra", "voudrons", "voudrez", "voudront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["veuille", "veuilles", "veuille", "voulions", "vouliez", "veuillent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["voulu"]
    ];
  }
}

final class Pouvoir extends Verbe {
  Pouvoir() {
    infinitif = "Pouvoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["peux", "peux", "peut", "pouvons", "pouvez", "peuvent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["pourrai", "pourras", "pourra", "pourrons", "pourrez", "pourront"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["puisse", "puisses", "puisse", "puissions", "puissiez", "puissent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["pu"]
    ];
  }
}

final class Savoir extends Verbe {
  Savoir() {
    infinitif = "Savoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["sais", "sais", "sait", "savons", "savez", "savent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["saurai", "sauras", "saura", "saurons", "saurez", "sauront"]
    ];

    modele.formes[TempsImperatif()] = [
      pronomsPersonnelsImperatif,
      ["sache", "sachons", "sachez"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["sache", "saches", "sache", "sachons", "sachez", "sachent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["su"]
    ];

    modele.formes[TempsParticipePresent()] = [
      pronomsPersonnelsParticipes,
      ["sachant"]
    ];
  }
}

final class Falloir extends Verbe {
  Falloir() {
    infinitif = "Falloir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsImpersonnel,
      ["faut"]
    ];

    modele.formes[TempsImparfait()] = [
      pronomsPersonnelsImpersonnel,
      ["fallait"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsImpersonnel,
      ["faudra"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsImpersonnelSubjonctif,
      ["faille"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["fallu"]
    ];
  }
}

final class Pleuvoir extends Verbe {
  Pleuvoir() {
    infinitif = "Pleuvoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsImpersonnel,
      ["pleut"]
    ];

    modele.formes[TempsImparfait()] = [
      pronomsPersonnelsImpersonnel,
      ["pleuvait"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsImpersonnel,
      ["pleuvra"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsImpersonnelSubjonctif,
      ["pleuve"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["plu"]
    ];
  }
}

final class Faire extends Verbe {
  Faire() {
    infinitif = "Faire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["fais", "fais", "fait", "faisons", "faites", "font"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["ferai", "feras", "fera", "ferons", "ferez", "feront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["fait"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["fasse", "fasses", "fasse", "fassions", "fassiez", "fassent"]
    ];
  }
}

final class Mourir extends Verbe {
  Mourir() {
    infinitif = "Mourir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["meurs", "meurs", "meurt", "mourons", "mourez", "meurent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["mourrai", "mourras", "mourra", "mourrons", "mourrez", "mourront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["mort"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["meure", "meures", "meure", "mourions", "mouriez", "meurent"]
    ];
  }
}

final class Valoir extends Verbe {
  Valoir() {
    infinitif = "Valoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["vaux", "vaux", "vaut", "valons", "valez", "valent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["vaudrai", "vaudras", "vaudra", "vaudrons", "vaudrez", "vaudront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["valu"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["vaille", "vailles", "vaille", "valions", "valiez", "vaillent"]
    ];
  }
}

final class Battre extends Verbe {
  Battre() {
    infinitif = "Battre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["bats", "bats", "bat", "battons", "battez", "battent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["battu"]
    ];
  }
}

final class Conclure extends Verbe {
  Conclure() {
    infinitif = "Conclure";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["conclus", "conclus", "conclut", "concluons", "concluez", "concluent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["conclu"]
    ];
  }
}

final class Boire extends Verbe {
  Boire() {
    infinitif = "Boire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["bois", "bois", "boit", "buvons", "buvez", "boivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["bu"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["boive", "boives", "boive", "buvions", "buviez", "boivent"]
    ];
  }
}

final class Croire extends Verbe {
  Croire() {
    infinitif = "Croire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["crois", "crois", "croit", "croyons", "croyez", "croient"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["cru"]
    ];
  }
}

final class Dormir extends Verbe {
  Dormir() {
    infinitif = "Dormir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["dors", "dors", "dort", "dormons", "dormez", "dorment"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["dormi"]
    ];
  }
}

final class Lire extends Verbe {
  Lire() {
    infinitif = "Lire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["lis", "lis", "lit", "lisons", "lisez", "lisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["lu"]
    ];
  }
}

final class Naitre extends Verbe {
  Naitre() {
    infinitif = "Naître";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["nais", "nais", "naît", "naissons", "naissez", "naissent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["né"]
    ];
  }
}

final class Partir extends Verbe {
  Partir() {
    infinitif = "Partir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["pars", "pars", "part", "partons", "partez", "partent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["parti"]
    ];
  }
}

final class Plaire extends Verbe {
  Plaire() {
    infinitif = "Plaire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["plais", "plais", "plaît", "plaisons", "plaisez", "plaisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["plu"]
    ];
  }
}

final class Resoudre extends Verbe {
  Resoudre() {
    infinitif = "Résoudre";
    sousGroupe = SousGroupeOudre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["résous", "résous", "résout", "résolvons", "résolvez", "résolvent"]
    ];
    
    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["résolu"]
    ];
  }
}

final class Rire extends Verbe {
  Rire() {
    infinitif = "Rire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["ris", "ris", "rit", "rions", "riez", "rient"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["ri"]
    ];
  }
}

final class Sourire extends Verbe {
  Sourire() {
    infinitif = "Sourire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["souris", "souris", "sourit", "sourions", "souriez", "sourient"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["souri"]
    ];
  }
}

final class Sentir extends Verbe {
  Sentir() {
    infinitif = "Sentir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["sens", "sens", "sent", "sentons", "sentez", "sentent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["senti"]
    ];
  }
}

final class Servir extends Verbe {
  Servir() {
    infinitif = "Servir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["sers", "sers", "sert", "servons", "servez", "servent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["servi"]
    ];
  }
}

final class Sortir extends Verbe {
  Sortir() {
    infinitif = "Sortir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["sors", "sors", "sort", "sortons", "sortez", "sortent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["sorti"]
    ];
  }
}

final class Suivre extends Verbe {
  Suivre() {
    infinitif = "Suivre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["suis", "suis", "suit", "suivons", "suivez", "suivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["suivi"]
    ];
  }
}

final class Suffire extends Verbe {
  Suffire() {
    infinitif = "Suffire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["suffis", "suffis", "suffit", "suffisons", "suffisez", "suffisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["suffi"]
    ];
  }
}

final class SeTaire extends Verbe {
  SeTaire() {
    infinitif = "Se taire";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "me tais",
        "te tais",
        "se tait",
        "nous taisons",
        "vous taisez",
        "se taisent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["tu"]
    ];
  }
}

final class Vaincre extends Verbe {
  Vaincre() {
    infinitif = "Vaincre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["vaincs", "vaincs", "vainc", "vainquons", "vainquez", "vainquent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["vaincu"]
    ];
  }
}

final class Convaincre extends Verbe {
  Convaincre() {
    infinitif = "Convaincre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "convaincs",
        "convaincs",
        "convainc",
        "convainquons",
        "convainquez",
        "convainquent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["convaincu"]
    ];
  }
}

final class Vivre extends Verbe {
  Vivre() {
    infinitif = "Vivre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["vis", "vis", "vit", "vivons", "vivez", "vivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["vécu"]
    ];
  }
}

final class Survivre extends Verbe {
  Survivre() {
    infinitif = "Survivre";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["survis", "survis", "survit", "survivons", "survivez", "survivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["survécu"]
    ];
  }
}

final class Cueillir extends Verbe {
  Cueillir() {
    infinitif = "Cueillir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["cueille", "cueilles", "cueille", "cueillons", "cueillez", "cueillent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "cueillerai",
        "cueilleras",
        "cueillera",
        "cueillerons",
        "cueillerez",
        "cueilleront"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["cueilli"]
    ];
  }
}

final class Accueillir extends Verbe {
  Accueillir() {
    infinitif = "Accueillir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      [
        "accueille",
        "accueilles",
        "accueille",
        "accueillons",
        "accueillez",
        "accueillent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      [
        "accueillerai",
        "accueilleras",
        "accueillera",
        "accueillerons",
        "accueillerez",
        "accueilleront"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["accueilli"]
    ];
  }
}

final class Courir extends Verbe {
  Courir() {
    infinitif = "Courir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["cours", "cours", "court", "courons", "courez", "courent"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["courrai", "courras", "courra", "courrons", "courrez", "courront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["couru"]
    ];
  }
}

final class Parcourir extends Verbe {
  Parcourir() {
    infinitif = "Parcourir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "parcours",
        "parcours",
        "parcourt",
        "parcourons",
        "parcourez",
        "parcourent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "parcourrai",
        "parcourras",
        "parcourra",
        "parcourrons",
        "parcourrez",
        "parcourront"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["parcouru"]
    ];
  }
}

final class Voir extends Verbe {
  Voir() {
    infinitif = "Voir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["vois", "vois", "voit", "voyons", "voyez", "voient"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      ["verrai", "verras", "verra", "verrons", "verrez", "verront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["vu"]
    ];
  }
}

final class Prevoir extends Verbe {
  Prevoir() {
    infinitif = "Prévoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["prévois", "prévois", "prévoit", "prévoyons", "prévoyez", "prévoient"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "prévoirai",
        "prévoiras",
        "prévoira",
        "prévoirons",
        "prévoirez",
        "prévoiront"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["prévu"]
    ];
  }
}

final class Envoyer extends Verbe {
  Envoyer() {
    infinitif = "Envoyer";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["envoie", "envoies", "envoie", "envoyons", "envoyez", "envoient"]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsVoyelle,
      ["enverrai", "enverras", "enverra", "enverrons", "enverrez", "enverront"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["envoyé"]
    ];
  }
}

final class SAsseoir extends Verbe {
  SAsseoir() {
    infinitif = "S'asseoir";
    sousGroupe = SousGroupeAucun();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "m'assois / m'assieds",
        "t'assois / t'assieds",
        "s'assoit / s'assied",
        "nous assoyons / nous asseyons",
        "vous assoyez / vous asseyez",
        "s'assoient / s'asseyent"
      ]
    ];

    modele.formes[TempsFuturSimple()] = [
      pronomsPersonnelsConsonne,
      [
        "m'assoirai / m'assiérai",
        "t'assoiras / t'assiéras",
        "s'assoira / s'assiéra",
        "nous assoirons / nous assiérons",
        "vous assoirez / vous assiérez",
        "s'assoiront / s'assiéront"
      ]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      [
        "m'assoie / m'asseye",
        "t'assoie / t'asseye",
        "s'assoie / s'asseye",
        "nous assoyions / nous asseyions",
        "vous assoyiez / vous asseyiez",
        "s'assoient / s'asseyent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["assis"]
    ];
  }
}

// Dire et ses composés
final class Dire extends Verbe {
  Dire() {
    infinitif = "Dire";
    sousGroupe = SousGroupeDire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["dis", "dis", "dit", "disons", "dites", "disent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["dit"]
    ];
  }
}

final class Interdire extends Verbe {
  Interdire() {
    infinitif = "Interdire";
    sousGroupe = SousGroupeDire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      [
        "interdis",
        "interdis",
        "interdit",
        "interdisons",
        "interdisez",
        "interdisent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["interdit"]
    ];
  }
}

final class Redire extends Verbe {
  Redire() {
    infinitif = "Redire";
    sousGroupe = SousGroupeDire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["redis", "redis", "redit", "redisons", "redites", "redisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["redit"]
    ];
  }
}

final class Predire extends Verbe {
  Predire() {
    infinitif = "Prédire";
    sousGroupe = SousGroupeDire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["prédis", "prédis", "prédit", "prédisons", "prédisez", "prédisent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["prédit"]
    ];
  }
}

final class Maudire extends Verbe {
  Maudire() {
    infinitif = "Maudire";
    sousGroupe = SousGroupeDire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["maudis", "maudis", "maudit", "maudissons", "maudissez", "maudissent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["maudit"]
    ];
  }
}

// Écrire et ses composés
final class Ecrire extends Verbe {
  Ecrire() {
    infinitif = "Écrire";
    sousGroupe = SousGroupeEcrire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["écris", "écris", "écrit", "écrivons", "écrivez", "écrivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["écrit"]
    ];
  }
}

final class Inscrire extends Verbe {
  Inscrire() {
    infinitif = "Inscrire";
    sousGroupe = SousGroupeEcrire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["inscris", "inscris", "inscrit", "inscrivons", "inscrivez", "inscrivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["inscrit"]
    ];
  }
}

final class Reecrire extends Verbe {
  Reecrire() {
    infinitif = "Réécrire";
    sousGroupe = SousGroupeEcrire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["réécris", "réécris", "réécrit", "réécrivons", "réécrivez", "réécrivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["réécrit"]
    ];
  }
}

final class Decrire extends Verbe {
  Decrire() {
    infinitif = "Décrire";
    sousGroupe = SousGroupeEcrire();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["décris", "décris", "décrit", "décrivons", "décrivez", "décrivent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["décrit"]
    ];
  }
}

// Prendre et composés
final class Prendre extends Verbe {
  Prendre() {
    infinitif = "Prendre";
    sousGroupe = SousGroupePrendre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["prends", "prends", "prend", "prenons", "prenez", "prennent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["pris"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["prenne", "prennes", "prenne", "prenions", "preniez", "prennent"]
    ];
  }
}

final class Comprendre extends Verbe {
  Comprendre() {
    infinitif = "Comprendre";
    sousGroupe = SousGroupePrendre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "comprends",
        "comprends",
        "comprend",
        "comprenons",
        "comprenez",
        "comprennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["compris"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["comprenne", "comprennes", "comprenne", "comprenions", "compreniez", "comprennent"]
    ];
  }
}

final class Apprendre extends Verbe {
  Apprendre() {
    infinitif = "Apprendre";
    sousGroupe = SousGroupePrendre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsVoyelle,
      ["apprends", "apprends", "apprend", "apprenons", "apprenez", "apprennent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["appris"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsVoyelleSubjonctif,
      ["apprenne", "apprennes", "apprenne", "apprenions", "appreniez", "apprennent"]
    ];
  }
}

final class Surprendre extends Verbe {
  Surprendre() {
    infinitif = "Surprendre";
    sousGroupe = SousGroupePrendre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "surprends",
        "surprends",
        "surprend",
        "surprenons",
        "surprenez",
        "surprennent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["surpris"]
    ];

    modele.formes[TempsSubjonctif()] = [
      pronomsPersonnelsConsonneSubjonctif,
      ["surprenne", "surprennes", "surprenne", "surprenions", "surpreniez", "surprennent"]
    ];
  }
}

// Groupe "mettre"
final class Mettre extends Verbe {
  Mettre() {
    infinitif = "Mettre";
    sousGroupe = SousGroupeMettre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["mets", "mets", "met", "mettons", "mettez", "mettent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["mis"]
    ];
  }
}

final class Promettre extends Verbe {
  Promettre() {
    infinitif = "Promettre";
    sousGroupe = SousGroupeMettre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["promets", "promets", "promet", "promettons", "promettez", "promettent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["promis"]
    ];
  }
}

final class Permettre extends Verbe {
  Permettre() {
    infinitif = "Permettre";
    sousGroupe = SousGroupeMettre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      ["permets", "permets", "permet", "permettons", "permettez", "permettent"]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["permis"]
    ];
  }
}

final class Transmettre extends Verbe {
  Transmettre() {
    infinitif = "Transmettre";
    sousGroupe = SousGroupeMettre();

    modele.formes[TempsPresent()] = [
      pronomsPersonnelsConsonne,
      [
        "transmets",
        "transmets",
        "transmet",
        "transmettons",
        "transmettez",
        "transmettent"
      ]
    ];

    modele.formes[TempsParticipePasse()] = [
      pronomsPersonnelsParticipes,
      ["transmis"]
    ];
  }
}

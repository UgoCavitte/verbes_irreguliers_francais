// Noms des nomSous-groupes
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

const String nomSousGroupeAucun = "très irréguliers";
const String nomSousGroupeAppelerJeter = "appeler/jeter";
const String nomSousGroupeDire = "dire";
const String nomSousGroupeEcrire = "écrire";
const String nomSousGroupeEER = "é*er/e*er";
const String nomSousGroupeEnir = "-enir";
const String nomSousGroupeEvoir = "-evoir";
const String nomSousGroupeIndre = "-indre";
const String nomSousGroupeMettre = "mettre";
const String nomSousGroupeOudre = "-oudre";
const String nomSousGroupePrendre = "prendre";
const String nomSousGroupeUire = "-uire";
const List<String> listeNomSousGroupes = [
  nomSousGroupeAucun,
  nomSousGroupeAppelerJeter,
  nomSousGroupeDire,
  nomSousGroupeEcrire,
  nomSousGroupeEER,
  nomSousGroupeEnir,
  nomSousGroupeEvoir,
  nomSousGroupeIndre,
  nomSousGroupeMettre,
  nomSousGroupeOudre,
  nomSousGroupePrendre,
  nomSousGroupeUire
];

final class SousGroupeAucun extends SousGroupe {
  SousGroupeAucun() {
    nom = nomSousGroupeAucun;
  }
}

final class SousGroupeAppelerJeter extends SousGroupe {
  SousGroupeAppelerJeter() {
    nom = nomSousGroupeAppelerJeter;
  }
}

final class SousGroupeDire extends SousGroupe {
  SousGroupeDire() {
    nom = nomSousGroupeDire;
  }
}

final class SousGroupeEcrire extends SousGroupe {
  SousGroupeEcrire() {
    nom = nomSousGroupeEcrire;
  }
}

final class SousGroupeEER extends SousGroupe {
  SousGroupeEER() {
    nom = nomSousGroupeEER;
  }
}

final class SousGroupeEnir extends SousGroupe {
  SousGroupeEnir() {
    nom = nomSousGroupeEnir;
  }
}

final class SousGroupeEvoir extends SousGroupe {
  SousGroupeEvoir() {
    nom = nomSousGroupeEvoir;
  }
}

final class SousGroupeIndre extends SousGroupe {
  SousGroupeIndre() {
    nom = nomSousGroupeIndre;
  }
}

final class SousGroupeMettre extends SousGroupe {
  SousGroupeMettre() {
    nom = nomSousGroupeMettre;
  }
}

final class SousGroupeOudre extends SousGroupe {
  SousGroupeOudre() {
    nom = nomSousGroupeOudre;
  }
}

final class SousGroupePrendre extends SousGroupe {
  SousGroupePrendre() {
    nom = nomSousGroupePrendre;
  }
}

final class SousGroupeUire extends SousGroupe {
  SousGroupeUire() {
    nom = nomSousGroupeUire;
  }
}

List<SousGroupe> listeSousGroupes = [
  SousGroupeAucun(),
  SousGroupeAppelerJeter(),
  SousGroupeDire(),
  SousGroupeEcrire(),
  SousGroupeEER(),
  SousGroupeEnir(),
  SousGroupeEvoir(),
  SousGroupeIndre(),
  SousGroupeOudre(),
  SousGroupePrendre(),
  SousGroupeUire()
];

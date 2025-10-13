import '../types/types_temps.dart';

// Noms des temps
const String nomPresent = "Présent";
const String nomImparfait = "Imparfait";
const String nomFuturSimple = "Futur simple";
const String nomImperatif = "Impératif";
const String nomSubjonctif = "Subjonctif présent";
const String nomParticipePasse = "Participe passé";
const String nomParticipePresent = "Participe présent";
const List<String> listeNomsTemps = [
  nomPresent,
  nomImparfait,
  nomFuturSimple,
  nomImperatif,
  nomSubjonctif,
  nomParticipePasse,
  nomParticipePresent
];

List<Temps> listeTemps = [
  TempsPresent(),
  TempsImparfait(),
  TempsFuturSimple(),
  TempsImperatif(),
  TempsSubjonctif(),
  TempsParticipePasse(),
  TempsParticipePresent()
];

final class TempsPresent extends Temps {
  TempsPresent() {
    nom = nomPresent;
  }
}

final class TempsImparfait extends Temps {
  TempsImparfait() {
    nom = nomImparfait;
  }
}

final class TempsFuturSimple extends Temps {
  TempsFuturSimple() {
    nom = nomFuturSimple;
  }
}

final class TempsImperatif extends Temps {
  TempsImperatif() {
    nom = nomImperatif;
  }
}

final class TempsSubjonctif extends Temps {
  TempsSubjonctif() {
    nom = nomSubjonctif;
  }
}

final class TempsParticipePasse extends Temps {
  TempsParticipePasse() {
    nom = nomParticipePasse;
  }
}

final class TempsParticipePresent extends Temps {
  TempsParticipePresent() {
    nom = nomParticipePresent;
  }
}

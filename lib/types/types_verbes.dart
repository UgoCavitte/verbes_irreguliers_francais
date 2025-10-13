import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';
import 'types_containers.dart';
import '../data/verbes.dart';
import 'types_temps.dart';

class Verbe {
  String infinitif = "default";
  SousGroupe sousGroupe = SousGroupe();
  Modele modele = Modele();

  Verbe();

  Verbe.par({required this.infinitif});

  // Renvoie les temps où le verbe est irrégulier
  List<Temps> getTempsPossibles() {
    return modele.formes.keys.toList();
  }

  // Autres méthodes
  Column createPagePresentation() {
    List<CardConjugaison> listeTemps = <CardConjugaison>[];

    modele.formes.forEach((temps, formes) {
      if (formes[0][0] != "g") {
        listeTemps.add(
          CardConjugaison(temps: temps.nom, conjugaison: formes),
        );
      }
    });

    return Column(
      children: <Widget>[CardInfinitif(verbe: this), ...listeTemps],
    );
  }

  // Correction des personnes
  /*
   * Est utilisé pour les petits affichages
   * Au départ, cette fonction remplaçait les nombres par des traits d'union 
   */
  static String correctionPersonnes(String personne) {
    switch (personne) {
      case "1":
        return "(Tu)";
      case "2":
        return "(Nous)";
      case "3":
        return "(Vous)";
      default:
        return personne;
    }
  }

  // Fait l'inverse de la fonction précédente pour permettre la vérification
  static String correctionPersonnesInversee(String personne) {
    switch (personne) {
      case "(Tu)":
        return "1";
      case "(Nous)":
        return "2";
      case "(Vous)":
        return "3";
      default:
        return personne;
    }
  }

  // Numéro de personne à l'imparfait -> texte
  // Est utilisé pour les questions avec des phrases
  static String numeroPersonneToTexte(String personne) {
    switch (personne) {
      case "1":
        return "La deuxième personne du singulier (tu)";
      case "2":
        return "La première personne du pluriel (nous)";
      case "3":
        return "La deuxième personne du pluriel (vous)";
      default:
        return "erreur";
    }
  }

  // Est utilisé pour la barre de recherche
  static String supprimerAccentsEtMajuscules(String inf) {
    String string = inf.toLowerCase();
    string = string.replaceAll("â", "a");
    string = string.replaceAll("ê", "e");
    string = string.replaceAll("é", "e");
    string = string.replaceAll("è", "e");
    string = string.replaceAll("î", "i");
    string = string.replaceAll("ô", "o");
    string = string.replaceAll("s'", "");
    string = string.replaceAll("se ", "");

    return string;
  }

  // Permet de trouver un verbe à partir d'un string de son infinitif
  static Verbe verbFromString(String inf) {
    for (Verbe verbe in listeVerbes) {
      if (verbe.infinitif == inf) return verbe;
    }
    return Etre();
  }

  static List<Verbe> trierOrdre(List<Verbe> liste) {
    // Met les verbes dans l'ordre alphabétique
    liste.sort((a, b) => Verbe.supprimerAccentsEtMajuscules(a.infinitif)
        .compareTo(Verbe.supprimerAccentsEtMajuscules(b.infinitif)));

    return liste;
  }

  static bool verifierForme(
      {required String formeCorrecte, required String formeDonnee}) {
    // Cas où le verbe a seulement une forme
    // Ou si l'utilisateur a tout entré lui-même
    if (formeCorrecte == formeDonnee) {
      return true;
    }
    // Sinon, il faut faire une liste avec ces formes et les vérifier une à une
    else {
      // Cas où l'utilisateur a juste mal répondu
      if (!formeCorrecte.contains("/")) {
        return false;
      }
      // Vérifier les formes une à une
      else {
        // Répartie les formes dans une liste
        List<String> chars = formeCorrecte.split("");
        List<String> formeEnCours = [];
        List<String> formesTrouvees = [];

        // On itère tous les lettres
        for (int i = 0; i < chars.length; i++) {
          // Si le caractère n'est pas un espace
          // OU
          // Si ce qu'on a accumulé jusqu'à maintenant est un pronom
          // Alors on continue
          if (chars[i] != " " ||
              ["me", "te", "se", "nous", "vous"]
                  .contains(formeEnCours.join())) {
            formeEnCours.add(chars[i]);
          } else {
            formesTrouvees.add(formeEnCours.join());
            formeEnCours = [];

            i += 2; // enlève " / "
          }
        }
        // Ajoute la dernière forme
        formesTrouvees.add(formeEnCours.join());

        // Vérifie les formes de la liste
        return formesTrouvees.contains(formeDonnee) ? true : false;
      }
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is! Verbe) {
      return false;
    }
    return infinitif == other.infinitif;
  }

  @override
  int get hashCode => infinitif.hashCode;
}

class VerbeApprisOuRevise extends Verbe {
  final Temps temps;

  VerbeApprisOuRevise({required String inf, required this.temps})
      : super.par(infinitif: inf);

  @override
  bool operator ==(Object other) {
    if (other is! Verbe) {
      return false;
    }

    // Cas où on compare à un verbe appris ou réviser
    if (other is VerbeApprisOuRevise) {
      return (infinitif == other.infinitif && temps == other.temps);
    }

    return infinitif == other.infinitif;
  }

  @override
  int get hashCode => infinitif.hashCode;
}

class Modele {
  /*
   * La clé de type String correspond au temps
   * La double liste contient un premier élément - le pronom - et un second - la
   * forme conjugée. 
   */

  Map<Temps, List<List<String>>> formes = {};

  static List<Text> fromListeDePronomsToListeDeText(List<String> pronoms) {
    List<Text> toReturn = <Text>[];

    for (var text in pronoms) {
      toReturn.add(Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(color: couleurTextePronomsEtFormes, fontSize: taillePolice),
      ));
    }
    return toReturn;
  }

  static List<Text> fromListeDeFormesToListeDeText(List<String> formes) {
    List<Text> toReturn = <Text>[];
    for (var text in formes) {
      toReturn.add(Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(color: couleurTextePronomsEtFormes, fontSize: taillePolice)));
    }
    return toReturn;
  }
}

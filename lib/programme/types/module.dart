import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';

/*
 * Un module est une sous-partie du programme d'apprentissage.
 * 
 * Chaque module correspond à un temps (ou une forme).
 */

abstract class Module {
  // Liste des étapes comprises dans ce module.
  // Il existe deux types : apprentissage et révision
  late final List<Etape> etapes;

  // Phrase descriptive de ce module
  late final String description;

  // ID unique
  late final String id;

  Module();

  @override
  bool operator ==(Object other) {
    if (other is! Module) {
      return false;
    } else if (id == other.id) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode;

  // FONCTIONS

  static Module moduleFromId(String id) {
    for (Module module in MyUser.programme.modules) {
      if (module.id == id) {
        return module;
      }
    }

    throw "Erreur de lecture du module en cours";
  }

  // Numérote les étapes
  void numeroterEtapes() {
    for (int i = 0; i < etapes.length; i++) {
      etapes[i].rang = i + 1;
    }
  }

  // Calcule la progression de l'utilisateur
  int getQtEtapesFaites() {
    int progression = 0;

    for (var etape in etapes) {
      if (etape.fait) progression++;
    }

    return progression;
  }

  // Vérifie si le module a été entièrement fait
  bool moduleFini() {
    int qt = 0;

    for (var etape in etapes) {
      if (etape.fait) qt++;
    }

    return qt == etapes.length;
  }
}

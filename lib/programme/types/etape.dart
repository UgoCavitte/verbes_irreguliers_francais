import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';

import '../../types/types_temps.dart';
import '../../types/types_verbes.dart';

/*
 * Une étape est une sous-partie d'un module.
 * 
 * Une étape peut être :
 * 1. une étape d'apprentissage ;
 * 2. une étape de révision.
 * 
 * Le contenu d'une étape est une liste de verbe dont les formes sont apprises
 * ou révisées dans le cadre de cette première. Le temps de l'étape correspond
 * au temps du module.
 * 
 * L'étape a deux états possibles : faite ou pas encore faite.
 */

abstract class Etape {
  /* Une étape a deux types possibles :
  * 1. apprentissage de nouvelles formes
  * 2. Révision de formes apprises précédemment
  */
  late final TypeEtape type;

  // Liste des verbes appris ou révisés dans cette étape
  late final List<Verbe> contenu;

  // Temps concerné
  late final Temps temps;

  // Court texte décrivant cette étape
  late final String description;

  // Numéro de l'étape
  late final int rang;

  // ID -> identifiant qui permet la sauvegarde en mémoire et qui évite les
  // problèmes pour les futures mises à jour
  late final String id;

  // Est-ce que cette étape a été faite par l'utilisateur
  // False par défaut. Passe à true quand l'utilisateur termine l'étape
  bool fait = false;

  late final Module module;

  Etape();

  static String listeVerbeEtapeString(List<Verbe> contenu) {
    String toReturn = "";

    for (int i = 0; i < contenu.length; i++) {
      i == contenu.length - 1
          ? toReturn += 'et "${contenu[i].infinitif.toLowerCase()}"'
          : toReturn += '"${contenu[i].infinitif.toLowerCase()}", ';
    }

    return toReturn;
  }

  void marquerFaite(bool bool) {
    // Exclure le cas où l'étape est déjà faite ou déjà non faite
    if (fait != bool) {
      // Marquer comme faite
      if (bool) {
        fait = true;
        if (type == TypeEtape.apprentissage) {
          for (var verbe in contenu) {
            MyUser.listeVerbesAppris
                .add(VerbeApprisOuRevise(inf: verbe.infinitif, temps: temps));
          }
        } else {
          for (var verbe in contenu) {
            MyUser.listeVerbesRevises
                .add(VerbeApprisOuRevise(inf: verbe.infinitif, temps: temps));
          }
        }
      }

      // Marquer comme non faite
      else {
        fait = false;
        if (type == TypeEtape.apprentissage) {
          for (var verbe in contenu) {
            MyUser.listeVerbesAppris.remove(verbe);
          }
        } else {
          for (var verbe in contenu) {
            MyUser.listeVerbesRevises.remove(verbe);
          }
        }
      }

      // Enregistrement en mémoire
      GestionMemoire.enregistrerCours(moduleModifie: module);
    }
  }
}

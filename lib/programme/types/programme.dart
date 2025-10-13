import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_futur.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_imparfait.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_imperatif.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_participe_passe.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_participe_present.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present2.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present3.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_subjonctif.dart';

import 'module.dart';

/*
 * Cet objet est contient le pogramme d'apprentissage des verbes irréguliers
 * contenus dans cette application.
 * 
 * Le programme se découpe en module.
 * Chaque module correspond à un temps
 * 
 * Les modules se découpent en étapes (plus de détails dans les classes
 * correspondantes).
 */

class Programme {
  // Liste des modules du programme
  late List<Module> modules = [];

  // Initialiser le programme à partir de ce qui est inscrit en mémoire
  // S'il n'est pas inscrit en mémoire, créer un programme avec une
  // progression nulle
  Programme() {
    // Lire en mémoire et recréer le programme en fonction de ce qui a été lu

    // Créer un programme lors du premier lancement
    if (true) {
      modules.addAll([
        ModulePresent(),
        ModuleImperatif(),
        ModulePresent2(),
        ModuleParticipePasse(),
        ModuleImparfait(),
        ModuleFutur(),
        ModuleParticipePresent(),
        ModulePresent3(),
        ModuleSubjonctif()
      ]);
    }
  }

  // FONCTIONS

  // Renvoie l'index du module à ouvrir sur la page d'apprentissage

  /*
   * Au départ, cette fonction renvoyait simplement le premier module non
   * terminé, mais cela créait des inconvénients pratiques quand l'utilisateur
   * étudiait les modules dans un autre ordre que dans celui proposé
   * 
   * Maintenant, cette fonction renvoie le dernier module étudié, si celui-ci
   * n'est pas terminé entièrement ; sinon, il renvoie le premier module
   * non terminé
   */

  int getIndexModuleAOuvrir() {
    // On commence par regarder si le module en cours n'est pas terminé
    if (MyUser.moduleEnCours.getQtEtapesFaites() !=
        MyUser.moduleEnCours.etapes.length) {
      int i = 0;
      for (i = 0; i < modules.length; i++) {
        if (modules[i] == MyUser.moduleEnCours) {
          return i;
        }
      }
    }

    // Si le module en cours est terminé, on prend le premier non terminé
    int i = 0;
    for (i = 0; i < modules.length; i++) {
      if (modules[i].getQtEtapesFaites() != modules[i].etapes.length) {
        return i;
      }
    }

    return 0;
  }

  // Calcule la progression en se basant sur le nombre d'étapes faites
  int getQtEtapesFaites() {
    int qtEtapesFaites = 0;

    for (var module in modules) {
      qtEtapesFaites += module.getQtEtapesFaites();
    }

    return qtEtapesFaites;
  }

  // Calcule le nombre d'étapes
  int getQtEtapes() {
    int qtEtapes = 0;

    for (var module in modules) {
      qtEtapes += module.etapes.length;
    }

    return qtEtapes;
  }

  // Calcule le nombre de modules faits
  int getNombreModulesFaits() {
    int qt = 0;

    for (var module in modules) {
      if (module.moduleFini()) qt++;
    }

    return qt;
  }
}

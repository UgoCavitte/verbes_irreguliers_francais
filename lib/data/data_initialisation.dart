import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/data/sous_groupes.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';

import '../types/types_temps.dart';
import '../types/types_verbes.dart';

abstract class DataInitialisation {
  static bool initialisationFaite = false;

  static Future<void> initialiserData() async {
    // Ajoute les verbes à chaque sous-groupe
    for (SousGroupe groupe in listeSousGroupes) {
      groupe.verbesDansCeGroupe.clear();
      for (Verbe v in listeVerbes) {
        if (v.sousGroupe == groupe) {
          groupe.verbesDansCeGroupe.add(v);
        }
      }
    }

    // Puis les met dans l'ordre
    for (var groupe in listeSousGroupes) {
      groupe.verbesDansCeGroupe = Verbe.trierOrdre(groupe.verbesDansCeGroupe);
    }

    // Ajoute les verbes aux temps auxquels ils sont irréguliers
    for (Temps t in listeTemps) {
      t.verbeIrreguliersACeTemps.clear();
    }

    for (Verbe verbe in listeVerbes) {
      for (Temps temps in listeTemps) {
        if (verbe.getTempsPossibles().contains(temps)) {
          temps.verbeIrreguliersACeTemps.add(verbe);
        }
      }
    }

    // Puis les met dans l'ordre
    for (var temps in listeTemps) {
      temps.verbeIrreguliersACeTemps =
          Verbe.trierOrdre(temps.verbeIrreguliersACeTemps);
    }

    // Set les modules des étapes
    for (Module module in MyUser.programme.modules) {
      for (Etape etape in module.etapes) {
        etape.module = module;
      }
    }

    // Partie mémoire

    // Chargement des modules faits
    await GestionMemoire.chargerModules();

    // Chargement des verbes vus ajd avec vérification de la date
    await GestionMemoire.chargerVerbesAjd();

    // Charge le module en cours
    await GestionMemoire.chargerModuleEnCours();

    // Charge les stats
    await GestionMemoire.chargerStatistiques();

    // Charge la limite d'étapes
    await GestionMemoire.chargerLimiteEtapes();

    // Charge la limite de révisions quotidiennes
    await GestionMemoire.chargerlimiteRevisionsQuotidiennes();

    // Charge le statut en cas d'absence de connexion internet
    await GestionMemoire.chargerStatut();

    return Future.delayed(const Duration(seconds: 1));
  }
}

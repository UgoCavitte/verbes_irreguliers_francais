import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/modules/module_present.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

abstract class GestionMemoire {
  // KEYS CONSTANTES
  static const String _keyVerbesAjd = "ajd";
  static const String _keyModuleEnCours = "mec";
  static const String _keyStatsApprentissage = "stappr";
  static const String _keyStatsRevision = "strev";
  static const String _keyStatsRevisionGenerale = "stgen";
  static const String _keyStatut = "statut";
  static const String _keyLimiteEtapes = "limet";
  static const String _keyRevisionsQuotidiennes = "revquot";
  static const String _keyTaillePolice = "tailPol";

  /*
   * Le système de sauvegarde des cours fonctionne de la manière suivant :
   * 
   * Les cours sont sauvegardés par module pour rendre la sauvegarde plus légère
   * 
   * Chaque étape a un id unique, par exemple "pr1_02" pour la deuxième étape du
   * premier module sur le présent
   * Cet id unique permet d'éviter les problèmes si je modifie le contenu des
   * modules : si la deuxième étape devient la troisième, elle conservera quand
   * même son id "pr1_02"
   */

  /////////////////////////////////////////////
  /// Enregistreurs
  //////////////////////////////////////////////

  // Enregistre les infos sur les cours
  static void enregistrerCours({required Module moduleModifie}) {
    // Commencer par supprimer tout ce qui avait été enregistré
    memoire.remove(moduleModifie.id);

    // Puis enregistrer
    // 1. Créer une liste de Strings avec les ID étapes dedans
    List<String> toSet =
        // Sélectionne les étapes faites
        moduleModifie.etapes
            .where((etape) => etape.fait)
            // Puis prend leurs ID
            .map((etape) => etape.id)
            .toList();

    // Puis enregistre
    memoire.setStringList(moduleModifie.id, toSet);
  }

  // Enregistre les infos sur les verbes faits "aujourd'hui"
  // Format "infinitifVerbe_nomTemps"
  static void enregistrerVerbesAjd() {
    // Les verbes sont sauvegardés avec le temps vu dans un même String
    // Les deux infos sont séparées par "_"
    List<String> listeInf = MyUser.listeVerbesRevisesAjd
        .map((verbe) => "${verbe.infinitif}_${verbe.temps.nom}")
        .toList();

    // Date en queue
    DateTime dateDate = DateTime.now();
    String dateString = "${dateDate.day}_${dateDate.month}_${dateDate.year}";
    listeInf.add(dateString);

    // Et on enregistre
    memoire.setStringList(_keyVerbesAjd, listeInf);
  }

  // Enregistre le module en cours
  static void enregistrerModuleEnCours() {
    memoire.setString(_keyModuleEnCours, MyUser.moduleEnCours.id);
  }

  // Enregistre les stats sur l'utilisateur
  static void enregistrerStats({required TypeStatistiques type}) {
    switch (type) {
      case TypeStatistiques.apprentissage:
        memoire.setInt(
            _keyStatsApprentissage, MyUser.stats.etapesApprentissageFaites);
      case TypeStatistiques.revision:
        memoire.setInt(_keyStatsRevision, MyUser.stats.etapesRevisionFaites);
      case TypeStatistiques.revisionGenerale:
        memoire.setInt(
            _keyStatsRevisionGenerale, MyUser.stats.revisionsGeneralesFaites);
    }
  }

  // Enregistre le statut premium en mémoire
  // Le statut est vérifié quand l'appli est connectée à Internet
  static void enregistrerStatut() {
    memoire.setBool(_keyStatut, MyUser.isPremium);
  }

  // Enregistre le nombre d'étapes faites aujourd'hui
  static void enregistrerLimiteEtapes() async {
    // Les données sont enregistrées dans une liste de String
    // Le premier élément contient la date
    // Le second contient le compte

    List<String> lu =
        await memoire.getStringList(_keyLimiteEtapes) ?? List.empty();

    DateTime now = DateTime.now();

    // S'il y avait quelque chose en mémoire
    if (lu.isNotEmpty) {
      // Si la date correspond
      if (lu[0] == "${now.year}${now.month}${now.day}") {
        memoire.setStringList(
            _keyLimiteEtapes, [lu[0], MyUser.etapesFaitesAjd.toString()]);
      }
    }

    // Si la date ne correspond pas
    // S'il n'y avait rien en mémoire
    else {
      memoire.setStringList(
          _keyLimiteEtapes, ["${now.year}${now.month}${now.day}", "1"]);
    }
  }

  // Enregistre le nombre de révisions faites aujourd'hui
  static void enregistrerLimiteRevisionsQuotidiennes() async {
    // Les données sont enregistrées dans une liste de String
    // Le premier élément contient la date
    // Le second contient le compte

    List<String> lu =
        await memoire.getStringList(_keyRevisionsQuotidiennes) ?? List.empty();

    DateTime now = DateTime.now();

    // S'il y avait quelque chose en mémoire
    if (lu.isNotEmpty) {
      // Si la date correspond
      if (lu[0] == "${now.year}${now.month}${now.day}") {
        memoire.setStringList(_keyRevisionsQuotidiennes,
            [lu[0], MyUser.revisionsQuotidiennesFaitesAjd.toString()]);
      }
    }

    // Si la date ne correspond pas
    // S'il n'y avait rien en mémoire
    else {
      memoire.setStringList(_keyRevisionsQuotidiennes,
          ["${now.year}${now.month}${now.day}", "1"]);
    }
  }

  // Enregiste la taille de police
  static Future<void> enregistrerTaillePolice() async {
    await memoire.setDouble(_keyTaillePolice, taillePolice);
  }

  //////////////////////////////////////////////
  /// Lecteurs
  //////////////////////////////////////////////

  // Set la liste des verbes appris ajd (avec vérification de la date)
  static Future<void> chargerVerbesAjd() async {
    List<String>? liste = await memoire.getStringList(_keyVerbesAjd);

    if (liste != null && liste.length > 1) {
      String dateFromMmr = liste.last;
      DateTime dateNow = DateTime.now();
      String dateNowString = "${dateNow.day}_${dateNow.month}_${dateNow.year}";

      // Si les dates sont les mêmes, ça veut dire que l'utilisateur a ouvert
      // l'appli plus tôt dans la journée
      // Dans ce cas-là, on charge les verbes
      if (dateNowString == dateFromMmr) {
        // On enlève la date pour ne laisser que les verbes
        liste.removeLast();

        // S'assure que la liste est vide
        MyUser.listeVerbesRevisesAjd.clear();

        // Puis on parse
        for (String string in liste) {
          List<String> verbe = [];
          List<String> temps = [];

          bool underscore = false;
          for (String char in string.split("")) {
            // Switch à l'underscore
            if (char == "_") {
              underscore = true;
            }
            // Temps
            else if (underscore) {
              temps.add(char);
            }
            // Infinitif
            else {
              verbe.add(char);
            }
          }

          // Convertir la liste en temps
          // Pas de telle nécessité pour le verbe
          Temps tempsTemps = Temps.tempsFromNom(temps.join());

          // Puis on ajoute
          MyUser.listeVerbesRevisesAjd
              .add(VerbeApprisOuRevise(inf: verbe.join(), temps: tempsTemps));
        }
      }

      // Sinon on la rend vide
      else {
        MyUser.listeVerbesRevisesAjd = {};
      }
    }
  }

  static Future<void> chargerModules() async {
    for (Module module in MyUser.programme.modules) {
      // Récupère la liste des rangs des étapes faites
      List<String>? toSet = await memoire.getStringList(module.id);

      if (toSet != null && toSet.isNotEmpty) {
        for (Etape etape in module.etapes) {
          // Si le rang de l'étape est dans la liste, ça veut dire qu'elle est
          // faite
          if (toSet.contains(etape.id)) {
            etape.fait = true;
          }
        }
      }
    }

    // Ensuite il faut set les listes des verbes appris et des verbes révisés
    MyUser.listeVerbesAppris = {};
    MyUser.listeVerbesRevises = {};
    for (Module module in MyUser.programme.modules) {
      for (Etape etape in module.etapes) {
        // Si l'étape a été faite
        if (etape.fait) {
          List<Verbe> verbes = [];
          verbes.addAll(etape.contenu);

          // Appris
          if (etape.type == TypeEtape.apprentissage) {
            for (Verbe verbe in verbes) {
              MyUser.listeVerbesAppris.add(VerbeApprisOuRevise(
                  inf: verbe.infinitif, temps: etape.temps));
            }
          }

          // Révisés
          else {
            for (Verbe verbe in verbes) {
              MyUser.listeVerbesRevises.add(VerbeApprisOuRevise(
                  inf: verbe.infinitif, temps: etape.temps));
            }
          }
        }
      }
    }
  }

  static Future<void> chargerModuleEnCours() async {
    String? id = await memoire.getString(_keyModuleEnCours);

    if (id != null) {
      MyUser.moduleEnCours = Module.moduleFromId(id);
    } else {
      MyUser.moduleEnCours = ModulePresent();
    }
  }

  static Future<void> chargerStatistiques() async {
    MyUser.stats.etapesApprentissageFaites =
        await memoire.getInt(_keyStatsApprentissage) ?? 0;
    MyUser.stats.etapesRevisionFaites =
        await memoire.getInt(_keyStatsRevision) ?? 0;
    MyUser.stats.revisionsGeneralesFaites =
        await memoire.getInt(_keyStatsRevisionGenerale) ?? 0;
  }

  static Future<void> chargerStatut() async {
    MyUser.isPremium = await memoire.getBool(_keyStatut) ?? false;
  }

  static Future<void> chargerLimiteEtapes() async {
    List<String> lu =
        await memoire.getStringList(_keyLimiteEtapes) ?? List.empty();

    DateTime now = DateTime.now();
    if (lu.isNotEmpty) {
      // Si la date correspond
      if (lu[0] == "${now.year}${now.month}${now.day}") {
        MyUser.etapesFaitesAjd = int.parse(lu[1]);
      }

      // Sinon
      else {
        MyUser.etapesFaitesAjd = 0;
      }
    }
  }

  static Future<void> chargerlimiteRevisionsQuotidiennes() async {
    List<String> lu =
        await memoire.getStringList(_keyRevisionsQuotidiennes) ?? List.empty();

    DateTime now = DateTime.now();
    if (lu.isNotEmpty) {
      // Si la date correspond
      if (lu[0] == "${now.year}${now.month}${now.day}") {
        MyUser.revisionsQuotidiennesFaitesAjd = int.parse(lu[1]);
      }

      // Sinon
      else {
        MyUser.revisionsQuotidiennesFaitesAjd = 0;
      }
    }
  }

  static Future<void> chargerTaillePolice() async {
    taillePolice = await memoire.getDouble(_keyTaillePolice) ?? taillePolice;
  }
}

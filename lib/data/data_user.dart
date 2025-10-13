import 'package:verbes_irreguliers_francais/programme/modules/module_present.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';
import 'package:verbes_irreguliers_francais/programme/types/programme.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

abstract class MyUser {
  /*
   * Le statut premium enlève les limites suivantes :
   * - 5 étapes par jour ;
   * - 4 révisions quotidiennes ;
   * - publicités.
   */
  static bool isPremium = false;

  static Module moduleEnCours = ModulePresent();

  /*
   * Cette liste est créée vide
   * 
   * Elle doit être récupérée à chaque lancement de l'appli et enregistrée après
   * chaque modification
   * 
   * Elle est remplie au fur et à mesure de la progression des étapes faites par
   * l'utilisateur
   * 
   */

  static Set<VerbeApprisOuRevise> listeVerbesAppris = {};
  static Set<VerbeApprisOuRevise> listeVerbesRevises = {};

  // Cette liste est utilisée par le bouton de révision générale pour éviter que
  // l'utilisateur ne tombe sur les mêmes verbes plusieurs fois dans la même
  // journée
  static Set<VerbeApprisOuRevise> listeVerbesRevisesAjd = {};

  /*
   * Programme d'apprentissage
   * 
   * Tout est géré dans son fichier
   */

  static Programme programme = Programme();

  /*
   * Limites quotidiennes
   * 
   * Les quotas sont inscrits dans le fichier "constantes d'apprentissage"
   */

  static int etapesFaitesAjd = 0;
  static int revisionsQuotidiennesFaitesAjd = 0;

  static Statistiques stats = Statistiques();
}

enum TypeStatistiques { apprentissage, revision, revisionGenerale }

class Statistiques {
  late int etapesApprentissageFaites;
  late int etapesRevisionFaites;
  late int revisionsGeneralesFaites;

  Statistiques() {
    etapesApprentissageFaites = 0;
    etapesRevisionFaites = 0;
    revisionsGeneralesFaites = 0;
  }

  // Modifieurs
  void ajouterEtapeApprentissageFaite() {
    etapesApprentissageFaites++;
  }

  void ajouterEtapeRevisionFaite() {
    etapesRevisionFaites++;
  }

  // Getters
  int getTotalEtapesFaites() {
    return etapesApprentissageFaites + etapesRevisionFaites;
  }

  int getTotalVerbesAppris() {
    return MyUser.listeVerbesAppris.length;
  }
}

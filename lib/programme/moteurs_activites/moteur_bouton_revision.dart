import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/programme/composants/progress_bar.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/conjugaison_melange.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/fin_revision_generale.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/presentation_revision.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/question_apprentissage_revision.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/questions_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_question_widget.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

/*
 * Ce fichier gère le bouton "réviser" sur la page apprentissage
 * 
 * Cette activité ne doit être lancée que dans le cas où il y a des verbes à
 * réviser (voir conditions plus bas)
 * 
 * L'application a la liste des verbes appris et révisés par l'utilisateur
 * Cette activité prend une certaine quantité de ces verbes et les fait réviser
 * à l'utilisateur
 * À la fin, elle enregistre les verbes fait CE JOUR-LÀ
 * 
 * Les activités doivent prendre en compte les temps vus des verbes
 * 
 * Les activités sont :
 * - remets dans l'ordre
 * - trouve parmi
 * - questions * 
 * 
 */

class MoteurBoutonRevision extends StatefulWidget {
  final List<VerbeApprisOuRevise> aReviser;

  const MoteurBoutonRevision({super.key, required this.aReviser});

  @override
  State<StatefulWidget> createState() => _MoteurBoutonRevisionState();
}

class _MoteurBoutonRevisionState extends State<MoteurBoutonRevision> {
  // Compte les parties faites, suit la progression de l'utilisateur dans
  // l'étape
  int _tour = 0;

  // Liste des verbes choisis
  final List<Verbe> _verbes = [];

  // Temps choisi
  Temps _tempsChoisi = TempsPresent();

  // Liste d'exos
  final List<ConjugaisonMelange> _listeConjugaisonMelangee = [];
  final List<TrouveParmiQuestionWidget> _listeTrouveParmi = [];
  final List<QuestionApprentissageRevision> _listeQuestions = [];

  // Index de la question
  int _indexQuestion = 0;

  // Suite
  void _suiteCM() {
    if (_listeConjugaisonMelangee.length - 1 > _indexQuestion) {
      _indexQuestion++;
    } else {
      _indexQuestion = 0;
      _tour++;
    }

    setState(() {});
  }

  void _questionSuivanteTP(bool bonOuPas) {
    // Remet la question à la fin si l'utilisateur a mal répondu
    if (!bonOuPas) {
      _listeTrouveParmi.add(TrouveParmiQuestionWidget.remettre(
          key: UniqueKey(), trouveParmi: _listeTrouveParmi[_indexQuestion]));
    }

    // Vérifie s'il reste des questions
    if (_listeTrouveParmi.length - 1 > _indexQuestion) {
      _indexQuestion++;
    } else {
      _indexQuestion = 0;
      _tour++;
    }

    setState(() {});
  }

  void _questionSuivanteQST(bool bonOuPas) {
    // Remet la question à la fin si l'utilisateur a mal répondu
    if (!bonOuPas) {
      // Il faut forcément recréer une question avec une nouvelle clé, sinon
      // elle garde les statuts de l'ancienne
      _listeQuestions.add(QuestionApprentissageRevision.remettre(
          key: UniqueKey(), qst: _listeQuestions[_indexQuestion]));
    }

    // Vérifie s'il reste des questions
    if (_listeQuestions.length - 1 > _indexQuestion) {
      _indexQuestion++;
    } else {
      _indexQuestion = 0;
      _tour++;
    }

    setState(() {});
  }

  int _getTotalParties() {
    switch (_tour) {
      case 0:
        return 1;
      case 1:
        return _listeConjugaisonMelangee.length;
      case 2:
        return _listeTrouveParmi.length;
      case 3:
        return _listeQuestions.length;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    if (!MyUser.isPremium) {
      Pub.loadAdInterstitial();
    }

    // On commence par trier les verbes révisés par temps pour commencer par le
    // temps qui a la plus grande quantité de verbes à réviser
    Map<Temps, int> tempsFaits = {};

    // Liste les temps à faire + ajoute 1 au compteur si le temps a déjà été
    // ajouté
    for (var verbe in widget.aReviser) {
      // Ajoute le temps à la map
      if (!tempsFaits.keys.contains(verbe.temps)) {
        tempsFaits[verbe.temps] = 0;
      }

      // Incrémente son compteur
      else {
        tempsFaits[verbe.temps] = tempsFaits[verbe.temps]! + 1;
      }

      // Définie le temps avec le plus d'entrées
      _tempsChoisi = tempsFaits.keys.toList()[0];
      int plusGrand = 0;
      for (var temps in tempsFaits.keys) {
        if (tempsFaits[temps]! > plusGrand) {
          _tempsChoisi = temps;
        }
      }
    }

    // Ensuite, on fait une sélection de 5 verbes max
    // Liste des verbes choisis
    List<VerbeApprisOuRevise> verbesChoisis = [];
    widget.aReviser.removeWhere((verbe) => verbe.temps != _tempsChoisi);
    widget.aReviser.shuffle();
    verbesChoisis = widget.aReviser
        .getRange(0, widget.aReviser.length > 5 ? 5 : widget.aReviser.length)
        .toList();

    // Transformer les verbes choisis en verbes classiques pour éviter les NULL
    for (var verbe in verbesChoisis) {
      _verbes.add(listeVerbes.firstWhere((toCheck) => verbe == toCheck));
    }

    // Remplit les listes
    // Conjugaison mélangée
    for (var verbe in _verbes) {
      _listeConjugaisonMelangee.add(ConjugaisonMelange(
          key: UniqueKey(),
          verbe: verbe,
          temps: _tempsChoisi,
          ajouterTour: _suiteCM));
    }

    // Trouve parmi renvoie directement une liste de questions
    _listeTrouveParmi.addAll(TrouveParmiMoteur.getQuestions(
        verbes: _verbes,
        temps: _tempsChoisi,
        grosseEtape: false,
        questionSuivante: _questionSuivanteTP));

    // Questions
    _listeQuestions.addAll(QuestionsMoteur.getQuestions(
        verbeEnCours: _verbes,
        verbeDejaFaits: [],
        temps: _tempsChoisi,
        typeEtape: TypeEtape.revision,
        grosseEtape: false,
        questionSuivante: _questionSuivanteQST));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = _getCurrentPage();

    List<Widget> toShow = [];

    if (_tour != 4) {
      toShow.add(Padding(
          padding: paddingGeneral,
          child: ProgressBar(
            indexGrosseEtape: _tour - 1,
            totalGrossesEtapes: 3,
            indexPartie: _indexQuestion,
            totalParties: _getTotalParties(),
          )));
    }

    toShow.add(Expanded(child: currentPage));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Révision"),
                  centerTitle: true,
                  foregroundColor: couleurTexteAppBar,
                  backgroundColor: couleurAppBar,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async => {
                      if (await confirm(context,
                          title: Text("Confirmez"),
                          content: Text("Voulez-vous vraiment sortir ?"),
                          textOK: Text(
                            "Oui",
                            style: textStyleGeneral,
                          ),
                          textCancel: Text(
                            "Non",
                            style: textStyleGeneral,
                          )))
                        {if (context.mounted) Navigator.pop(context)}
                    },
                  ),
                ),
                backgroundColor: couleurBackgroundGeneral,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: toShow,
                ))));
  }

  Widget _getCurrentPage() {
    // Le callback qui permet d'ajouter un à la boucle
    void ajouterTour() {
      // fait un setState pour relancer la page et permettre d'afficher ce
      // qu'il faut
      setState(() {
        _tour++;
      });
    }

    // Ouvre la page de présentation de l'étape si le tour vaut encore 0
    if (_tour == 0) {
      return PresentationRevision(
          verbes: _verbes, temps: _tempsChoisi, ajouterTour: ajouterTour);
    }

    // Remets dans l'ordre
    else if (_tour == 1 &&
        widget.aReviser[0].temps.typeDeTemps() != Temps.tempsTypeParticipe) {
      return _listeConjugaisonMelangee[_indexQuestion];
    } else if (_tour == 1) {
      // On skip si c'est un participe
      _tour++;
    }

    // Trouve parmi
    if (_tour == 2) {
      return _listeTrouveParmi[_indexQuestion];
    }

    // Questions
    else if (_tour == 3) {
      // Affiche seulement pour la première question, sinon elle n'est pas chargée
      if (interstitialAd.isLoaded && !MyUser.isPremium) {
        interstitialAd.show();
      }

      return _listeQuestions[_indexQuestion];
    }

    // Fin
    else {
      // Enregistrement des verbes
      List<VerbeApprisOuRevise> aEnregistrer = _verbes
          .map(
              (v) => VerbeApprisOuRevise(inf: v.infinitif, temps: _tempsChoisi))
          .toList();

      MyUser.listeVerbesRevisesAjd.addAll(aEnregistrer);
      GestionMemoire.enregistrerVerbesAjd();

      MyUser.stats.revisionsGeneralesFaites++;
      GestionMemoire.enregistrerStats(type: TypeStatistiques.revisionGenerale);

      MyUser.revisionsQuotidiennesFaitesAjd++;
      GestionMemoire.enregistrerLimiteRevisionsQuotidiennes();

      return FinRevisionGenerale(context: context);
    }
  }
}

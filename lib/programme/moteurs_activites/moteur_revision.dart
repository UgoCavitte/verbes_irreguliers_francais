import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/programme/composants/progress_bar.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/fin_apprentisssage.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/presentation_etape.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/question_apprentissage_revision.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/questions_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_question_widget.dart';
import 'package:verbes_irreguliers_francais/programme/types/etape.dart';
import 'package:verbes_irreguliers_francais/programme/types/module.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';

/*
 * Une étape de révision a un contenu particulier, précisé par son étape
 * 
 * Une étape de révision contient plusieurs exercices :
 * 1. Trouve parmi
 * 2. Écris en entier
 * 
 * Tous les verbes sont concernés par chaque étape
 * 
 * Si une étape contient beaucoup de verbes (constante), alors le système
 * change : 
 * 
 */

class MoteurRevision extends StatefulWidget {
  final Etape etape;
  final Module module;

  const MoteurRevision({super.key, required this.etape, required this.module});

  @override
  State<StatefulWidget> createState() => _MoteurRevisionState();
}

class _MoteurRevisionState extends State<MoteurRevision> {
  // Permet de raccourcir les étapes trop grosses
  bool grosseEtape = false;

  // Compte les tours
  int _tour = 0;

  int _indexQuestion = 0;

  // Liste des questions pour les exos
  final List<TrouveParmiQuestionWidget> _listeTrouveParmi = [];
  final List<QuestionApprentissageRevision> _listeQuestions = [];

  // Gère la liste des questions du TrouveParmi et du questionnaire
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

  @override
  void initState() {
    if (!MyUser.isPremium) {
      Pub.loadAdInterstitial();
    }
    // TODO -> afficher

    if (widget.etape.temps.typeDeTemps() != Temps.tempsTypeParticipe &&
        widget.etape.contenu.length > considererCommeGrossseEtape) {
      grosseEtape = true;
    }

    // Initialisation des listes
    // Le TP génère pour tous les verbes en même temps
    _listeTrouveParmi.addAll(TrouveParmiMoteur.getQuestions(
        verbes: widget.etape.contenu,
        temps: widget.etape.temps,
        grosseEtape: grosseEtape,
        questionSuivante: _questionSuivanteTP));

    _listeQuestions.addAll(QuestionsMoteur.getQuestions(
        verbeEnCours: widget.etape.contenu,
        verbeDejaFaits: [],
        temps: widget.etape.temps,
        typeEtape: widget.etape.type,
        grosseEtape: grosseEtape,
        questionSuivante: _questionSuivanteQST));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> toShow = [];

    Widget currentPage = _getCurrentPage();

    // N'affiche pas la barre de progression si l'étape est terminée
    if (_tour != 3) {
      toShow.add(Padding(
          padding: paddingGeneral,
          child: ProgressBar(
            indexGrosseEtape: _tour - 1,
            totalGrossesEtapes: 2,
            indexPartie: _indexQuestion,
            totalParties:
                _tour == 1 ? _listeTrouveParmi.length : _listeQuestions.length,
          )));
    }

    toShow.add(Expanded(child: currentPage));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "${widget.module.description} - Étape ${widget.etape.rang}",
                  ),
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

  // Renvoie le contenu à afficher
  Widget _getCurrentPage() {
    // Le callback qui permet d'ajouter un à la boucle
    void onChangeAjouterTour() {
      // fait un setState pour relancer la page et permettre d'afficher ce
      // qu'il faut
      setState(() {
        _tour++;
      });
    }

    // Ouvre la page de présentation de l'étape si le tour vaut encore 0
    if (_tour == 0) {
      return PresentationEtape(
        etape: widget.etape,
        module: widget.module,
        ajouterTour: onChangeAjouterTour,
      );
    }

    // Trouve parmi
    else if (_tour == 1) {
      return _listeTrouveParmi[_indexQuestion];
    }

    // Questions
    else if (_tour == 2) {
      // On évite le trop de pubs si ce sont des participes
      if (interstitialAd.isLoaded && !MyUser.isPremium) {
        interstitialAd.show();
      }

      return _listeQuestions[_indexQuestion];
    }

    // Étape terminée
    else {
      // Marquer l'étape étudiée comme faite
      widget.etape.marquerFaite(true);
      GestionMemoire.enregistrerCours(moduleModifie: widget.module);

      MyUser.stats.ajouterEtapeRevisionFaite();
      GestionMemoire.enregistrerStats(type: TypeStatistiques.revision);
      MyUser.moduleEnCours = widget.module;
      GestionMemoire.enregistrerModuleEnCours();

      // Ajoute 1 au compteur de session
      MyUser.etapesFaitesAjd++;
      GestionMemoire.enregistrerLimiteEtapes();

      return FinApprentissage(
        etape: widget.etape,
        module: widget.module,
        context: context,
      );
    }
  }
}

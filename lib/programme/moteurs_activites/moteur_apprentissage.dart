import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/programme/composants/progress_bar.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/conjugaison_melange.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/fin_apprentisssage.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/presentation_conjugaison.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/presentation_etape.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/question_apprentissage_revision.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/questions_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_moteur.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/exercices/trouve_parmi_question_widget.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';

import '../../data/constantes.dart';
import '../../types/types_verbes.dart';
import '../types/etape.dart';
import '../types/module.dart';

/*
 * Ce fichier comporte le mécanisme des étapes d'apprentissage.
 * Il prend l'étape en question en paramètre.
 * 
 * Le déroulement d'une étape d'apprentissage se divise en plusieurs parties :
 * 1. Présentation de la conjugaison du premier verbe ;
 * 2. Présente une conjugaison mélangée ;
 * AJOUT -> trouve parmi
 * 3. Questions pour lesquelles il faut répondre la forme entière. Si
 *    l'utilisateur ne répond pas correctement, la question doit être reposée ;
 * 4. Présentation de la conjugaison du deuxième verbe ;
 * 5. Équivalent de l'étape 2 ;
 * 6. Questions sur les formes entières avec adjonction de questions sur le
 *    premier verbe ;
 * 7. Et ainsi de suite pour les verbes suivants (les étapes comprennent
 *    généralement trois verbes);
 * ...
 * FIN. Intégrer une révision finale ?
 */

class MoteurApprentissage extends StatefulWidget {
  final Etape etape;
  final Module module;

  const MoteurApprentissage(
      {super.key, required this.etape, required this.module});

  @override
  State<StatefulWidget> createState() => _MoteurApprentissageState();
}

class _MoteurApprentissageState extends State<MoteurApprentissage> {
  // Compte les parties faites, suit la progression de l'utilisateur dans
  // l'étape
  int _tour = 0;

  int _indexQuestion = 0;

  int _indexVerbeEnCours = 0;

  // Liste des questions pour les exos
  final List<PresentationConjugaison> _listePresentationConjugaison = [];
  final List<ConjugaisonMelange> _listeConjugaisonMelangee = [];
  final List<TrouveParmiQuestionWidget> _listeTrouveParmi = [];
  final List<List<QuestionApprentissageRevision>> _listeQuestions = [];

  // Le callback qui permet d'ajouter un à la boucle
  void _ajouterTour() {
    // fait un setState pour relancer la page et permettre d'afficher ce
    // qu'il faut
    setState(() {
      _tour++;
    });
  }

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

  void _questionSuivante(bool bonOuPas) {
    // Remet la question à la fin si l'utilisateur a mal répondu
    if (!bonOuPas) {
      // Il faut forcément recréer une question avec une nouvelle clé, sinon
      // elle garde les statuts de l'ancienne
      _listeQuestions[_indexVerbeEnCours].add(
          QuestionApprentissageRevision.remettre(
              key: UniqueKey(),
              qst: _listeQuestions[_indexVerbeEnCours][_indexQuestion]));
    }

    // Vérifie s'il reste des questions
    if (_listeQuestions[_indexVerbeEnCours].length - 1 > _indexQuestion) {
      _indexQuestion++;
    } else {
      _indexQuestion = 0;
      _tour++;
    }

    setState(() {});
  }

  @override
  void initState() {
    // Initialise la pub
    Pub.loadAdInterstitial();

    // Initialisation des listes

    // Cette liste permet de faire des questions sur les verbes déjà faits
    List<Verbe> verbesFaits = [];

    for (var verbe in widget.etape.contenu) {
      // Présentation
      _listePresentationConjugaison.add(PresentationConjugaison(
          context: context,
          verbe: verbe,
          temps: widget.etape.temps,
          ajouterTour: _ajouterTour));

      // Conjugaison mélangée
      _listeConjugaisonMelangee.add(ConjugaisonMelange(
          key: UniqueKey(),
          verbe: verbe,
          temps: widget.etape.temps,
          ajouterTour: _ajouterTour));

      // Trouve parmi
      _listeTrouveParmi.addAll(TrouveParmiMoteur.getQuestions(
          verbes: [verbe],
          temps: widget.etape.temps,
          grosseEtape: false,
          questionSuivante: _questionSuivanteTP));

      // Questions
      _listeQuestions.add(QuestionsMoteur.getQuestions(
          verbeEnCours: [verbe],
          verbeDejaFaits: verbesFaits,
          temps: widget.etape.temps,
          typeEtape: widget.etape.type,
          grosseEtape: false,
          questionSuivante: _questionSuivante));

      // Remélange les questions par-dessus
      for (var liste in _listeQuestions) {
        liste.shuffle();
      }

      verbesFaits.add(verbe);
    }

    super.initState();
  }

  int _getProgression() {
    if (_tour == 0) {
      return 0;
    }

    // On montre la conjugaison
    else if (_tour % 3 == 1) {
      return 1;
    }
    // Conjugaison mélangée
    else if (_tour % 3 == 2) {
      return 2;
    }

    // Liste de questions
    else {
      return 2 + _indexQuestion + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> toShow = [];

    // On le fait avant pour éviter de mettre à jour la barre de progression
    // avant la mise à jour de l'index du verbe en cours
    Widget currentPage = _getCurrentPage();

    if (!(_tour / 3 > _getLengthContenu())) {
      toShow.add(
        Padding(
            padding: paddingGeneral,
            child: ProgressBar(
              indexGrosseEtape: _indexVerbeEnCours,
              totalGrossesEtapes: widget.etape.contenu.length,
              indexPartie: _getProgression(),
              totalParties: 3 + _listeQuestions[_indexVerbeEnCours].length,
            )),
      );
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

    // Chaque verbe demande trois tours pour être appris
    // On peut vérifier que l'apprentissage est terminé de cette manière
    else if (_tour / 3 > _getLengthContenu()) {
      // Marquer l'étape étudiée comme faite
      widget.etape.marquerFaite(true);
      GestionMemoire.enregistrerCours(moduleModifie: widget.module);

      MyUser.stats.ajouterEtapeApprentissageFaite();
      GestionMemoire.enregistrerStats(type: TypeStatistiques.apprentissage);
      MyUser.moduleEnCours = widget.module;
      GestionMemoire.enregistrerModuleEnCours();

      // Ajouter 1 au compteur de sessions
      MyUser.etapesFaitesAjd++;
      GestionMemoire.enregistrerLimiteEtapes();

      return FinApprentissage(
        etape: widget.etape,
        module: widget.module,
        context: context,
      );
    }

    // Répartition des parties en fonction du verbe en cours
    // Chaque verbe occupe trois parties, donc on peut trouver le type d'étape
    // avec un modulo

    // Montrer la conjugaison
    else if (_tour % 3 == 1) {
      // Il faut passer au verbe suivant à cette étape, si ce n'est pas le
      // premier verbe
      if (_tour != 1) {
        _indexVerbeEnCours++;

        // On évite le trop de pubs si ce sont des participes
        if (widget.etape.temps.typeDeTemps() != Temps.tempsTypeParticipe &&
            interstitialAd.isLoaded &&
            !MyUser.isPremium) {
          interstitialAd.show();
        }
      }

      return _listePresentationConjugaison[_getIndexVerbe()];
    }

    // Si l'étape n'est pas une étape de participes, alors on propose une
    // conjugaison mélangée
    if (_tour % 3 == 2) {
      if (!MyUser.isPremium) {
        Pub.loadAdInterstitial();
      }
      if (widget.etape.temps.typeDeTemps() != Temps.tempsTypeParticipe &&
              // Ne sont pas des participes
              widget.etape.contenu[0].modele.formes[widget.etape.temps]![0]
                      .length >
                  2
          // Ne sont pas des verbes impersonnels (ils sont toujours seuls dans les étapes)
          ) {
        return _listeConjugaisonMelangee[_indexVerbeEnCours];
      }
      // Sinon, on passe
      else {
        _tour++;
      }
    }

    // Poser des questions
    if (_tour % 3 == 0) {
      // S'arranger pour faire aller les verbes les uns après les autres
      return _listeQuestions[_indexVerbeEnCours][_indexQuestion];
    }

    // En cas de non-implémentation
    else {
      return Text("vide");
    }
  }

  int _getIndexVerbe() {
    return ((_tour - 1) / 3).floor();
  }

  int _getLengthContenu() {
    return widget.etape.contenu.length;
  }
}

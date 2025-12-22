import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/main.dart';
import 'package:verbes_irreguliers_francais/programme/composants/expansion_module.dart';
import 'package:verbes_irreguliers_francais/programme/composants/ligne_etape.dart';
import 'package:verbes_irreguliers_francais/programme/composants/titre_programme.dart';
import 'package:verbes_irreguliers_francais/programme/composants/titre_progression.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/programme/moteurs_activites/moteur_bouton_revision.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

import '../data/constantes.dart';

class PageApprendre extends StatefulWidget {
  const PageApprendre({super.key});

  @override
  State<StatefulWidget> createState() => _PageApprendreState();
}

class _PageApprendreState extends State<PageApprendre> {
  void onChange() {
    setState(() {});
  }

  List<Widget> toAdd = [];

  @override
  Widget build(BuildContext context) {

    Widget? ad = context.watch<ProviderAfficherAdBanner>().getAdBanner(context);

    toAdd.clear();

    // Regarde quel est le premier module non fait
    int indexAOuvrir = MyUser.programme.getIndexModuleAOuvrir();

    // Création des blocs
    // for (var module in User.programme.modules) {
    for (int i = 0; i < MyUser.programme.modules.length; i++) {
      List<Widget> contenuModule = [];
      for (var etape in MyUser.programme.modules[i].etapes) {
        contenuModule.add(Row(
          children: [
            Expanded(
                child: LigneEtape(
                    etape: etape,
                    module: MyUser.programme.modules[i],
                    onChangePageEntiere: onChange))
          ],
        ));
      }

      toAdd.add(ExpansionModule(
        key: UniqueKey(),
        module: MyUser.programme.modules[i],
        contenu: contenuModule,
        ouvertFerme: i == indexAOuvrir ? true : false,
        onChangePageEntiere: onChange,
      ));
    }

    return Scaffold(
        backgroundColor: couleurBackgroundGeneral,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, children: [
          
          if (ad != null)
            Center(child: SizedBox(
                height: 70,
                child: Padding(
                  padding: paddingGeneral,
                  child: ad,
                )),),
          
          Expanded(
              child: ListView(padding: paddingGeneral, children: [
            // Haut de la page
            TitreProgramme(),

            // Progression
            TitreProgression(),

            // Modules
            Padding(
              padding: paddingGeneral,
              child: Column(
                children: [...toAdd],
              ),
            )
          ])),

          // Bouton de révision
          Container(
              padding: paddingGeneral,
              decoration: const BoxDecoration(
                  border: BorderDirectional(
                      top: BorderSide(color: rouge, width: 3))),
              child: BoutonGrosGradientRouge(
                  text: "Révisions quotidiennes", action: action))
        ]));
  }

  Future<void> action() async {
    // Recharge la limite
    _refreshMemoire();

    // Si la limite est atteinte et que l'utilisateur n'est pas premium
    if (MyUser.revisionsQuotidiennesFaitesAjd >= limitesRevQuot &&
        !MyUser.isPremium) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Limite atteinte !"),
                content: Text(
                    "Vous avez atteint la limite d'une session de révisions quotidiennes aujourd'hui. Revenez demain ou débloquez la version premium de l'application dans la boutique (disponible uniquement sur Android pour le moment)."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Compris !",
                      style: textStyleGeneral,
                    ),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage(
                                    index: 3,
                                    skipLoading: true,
                                  )),
                          (Route<dynamic> route) => false),
                      child: Text(
                        "Aller dans la boutique",
                        style: textStyleGeneral,
                      ))
                ],
              ));
    } else {
      // Vérifier s'il y a des verbes appris et/ou révisés par
      // l'utilisateur qui n'ont pas été révisés aujourd'hui

      // On rassemble les deux listes appris/révisés
      Set<VerbeApprisOuRevise> aReviser = {};
      aReviser.addAll(MyUser.listeVerbesAppris);
      aReviser.addAll(MyUser.listeVerbesRevises);

      // On supprime les verbes déjà révisés
      for (var verbe in MyUser.listeVerbesRevisesAjd) {
        if (aReviser.contains(verbe)) {
          aReviser.remove(verbe);
        }
      }

      if (aReviser.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoteurBoutonRevision(
                    key: UniqueKey(), aReviser: aReviser.toList())));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Rien à réviser !"),
                  content: Text(
                      "Il n'y a rien à réviser en ce moment ! Soit vous avez révisé tout ce qui était possible aujourd'hui, soit vous n'avez pas encore commencé à apprendre."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Compris !",
                        style: textStyleGeneral,
                      ),
                    )
                  ],
                ));
      }
    }
  }

  void _refreshMemoire() async {
    await GestionMemoire.chargerlimiteRevisionsQuotidiennes();
  }
}

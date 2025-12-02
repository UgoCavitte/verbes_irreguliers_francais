import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/gestion/exercice_general.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/gestion/exercice_sur_temps.dart';

import '../data/constantes.dart';
import '../data/data_pub.dart';
import '../data/sous_groupes.dart';
import '../data/temps.dart';
import '../pages/exercices/gestion/exercice_sur_verbes.dart';
import '../types/radio_bouton.dart';
import '../types/types_boutons.dart';
import '../types/types_sous_groupes.dart';
import '../types/types_temps.dart';
import '../types/types_verbes.dart';
import 'exercices/gestion/exercice_sur_groupes_verbaux.dart';

/*
 * Ce menu sert à sélectionner le type de révision que l'utilisateur veut faire.
 * Il peut choisir entre :
 * 1. réviser un verbe
 * 2. réviser un temps
 * 3. réviser un sous-groupe
 * 
 * Il faudra aussi donner à l'utilisateur la possibilité d'affiner son choix.
 * Par exemple, il veut réviser le verbe "avoir" seulement au présent, ou bien
 * il veut réviser le sous-groupe -enir au futur simple.
 * 
 * Il faut aussi donner la possibilité de réviser en général
 */

class ReviserMenuNv extends StatelessWidget {
  const ReviserMenuNv({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? ad = context.watch<ProviderAfficherAdBanner>().getAdBanner(context);

    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: paddingGeneral,
                color: Colors.white,
                child: Text(
                  "Révision personnalisée",
                  style: TextStyle(
                      fontSize: taillePolice * 1.2, fontWeight: FontWeight.bold, color: bleu),
                  textAlign: TextAlign.center,
                ),
              ),
          Expanded(child: ReviserMenu()),
          if (ad != null)
            SizedBox(
                height: 70,
                child: Padding(
                  padding: paddingGeneral,
                  child: ad,
                ))
        ]));
  }
}

class ReviserMenu extends StatefulWidget {
  const ReviserMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ReviserMenuState();
}

class _ReviserMenuState extends State<ReviserMenu> {
  // général ou particulier
  // 0 = pas choisi, 1 = général, 2 = particulier
  int choixPrimaire = 0;

  // 0 = pas choisi, 1 = verbe, 2 = temps, 3 = groupe
  int choixVerbeTempsGroupe = 0;

  // 0 = pas choisi, 1 = tous les temps, 2 = temps particulier
  int choixVerbeTousTempsOuUnTemps = 0;

  // 0 = pas choisi, 1 = tous les temps, 2 = temps particulier
  int choixGroupeTousTempsOuUnTemps = 0;

  bool boolDeroulantVerbeFait = false;
  bool boolChoixTempsFait = false;
  bool boolChoixSousGroupe = false;
  bool boolChoixTempsVerbePrecis = false;
  bool boolChoixTempsGroupePrecis = false;

  Verbe choixVerbe = listeVerbes.first;
  Temps choixTemps = listeTemps.first;
  SousGroupe choixSousGroupe = listeSousGroupes.first;

  void toutFalse() {
    boolDeroulantVerbeFait = false;
    boolChoixTempsFait = false;
    boolChoixSousGroupe = false;
  }

  // Construction du Widget à afficher en fonction des choix de l'utilisateur
  List<Widget> toShow = [];

  @override
  Widget build(BuildContext context) {
    // Première ligne : général ou particulier ?
    List<Widget> premiereLigne = [
      Text(
        "Vous voulez réviser...",
        style: textStyleGeneral,
      ),
      // Ligne des radio buttons

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: RadioBouton(
                  Text("en général", style: textStyleGeneral),
                  1,
                  choixPrimaire, (value) {
            setState(() {
              choixPrimaire = value!;
              toutFalse();
            });
          })),
          Expanded(
              child: RadioBouton(
                  Text(
                    "quelque chose en particulier",
                    style: textStyleGeneral,
                  ),
                  2,
                  choixPrimaire, (value) {
            setState(() {
              choixPrimaire = value!;
              toutFalse();
            });
          }))
        ],
      )
    ];

    // Choix temps verbe ou groupe
    List<Widget> ligneChoixRevisionPrecise = [
      Text(
        "Qu'est-ce que vous voulez réviser ?",
        style: textStyleGeneral,
      ),

      // Ligne des radio buttons
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioBouton(
              Text(
                "un verbe",
                style: textStyleGeneral,
              ),
              1,
              choixVerbeTempsGroupe, (value) {
            setState(() {
              choixVerbeTempsGroupe = value!;
              toutFalse();
            });
          }),
          RadioBouton(
              Text(
                "un temps",
                style: textStyleGeneral,
              ),
              2,
              choixVerbeTempsGroupe, (value) {
            setState(() {
              choixVerbeTempsGroupe = value!;
              toutFalse();
            });
          }),
          RadioBouton(
              Text(
                "un sous-groupe",
                style: textStyleGeneral,
              ),
              3,
              choixVerbeTempsGroupe, (value) {
            setState(() {
              choixVerbeTempsGroupe = value!;
              toutFalse();
            });
          })
        ],
      ),
    ];

    // Choix du verbe
    List<Widget> ligneChoixVerbe = [
      Text(
        "Quel verbe réviser ?",
        style: textStyleGeneral,
      ),
      Padding(
          padding: paddingGeneral,
          child: DropdownMenu<Verbe>(
            menuHeight: 250,
            dropdownMenuEntries: Verbe.trierOrdre(listeVerbes)
                .map((v) => DropdownMenuEntry(value: v, label: v.infinitif))
                .toList(),
            onSelected: (verbe) {
              setState(() {
                boolDeroulantVerbeFait = true;
                choixVerbe = verbe!;
                if (boolChoixTempsVerbePrecis &&
                    !verbe.modele.formes.keys.contains(choixTemps)) {
                  boolChoixTempsVerbePrecis = false;
                }
              });
            },
          ))
    ];

    // Réviser ce verbe à tous les temps ?
    List<Widget> ligneChoixTousTempsVerbe = [
      Text(
        "Vous voulez réviser ce verbe...",
        style: textStyleGeneral,
      ),
      // Ligne des radio buttons

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: RadioBouton(
                  Text(
                    "à tous les temps",
                    style: textStyleGeneral,
                  ),
                  1,
                  choixVerbeTousTempsOuUnTemps, (value) {
            setState(() {
              choixVerbeTousTempsOuUnTemps = value!;
              boolChoixTempsFait = true;
            });
          })),
          Expanded(
              child: RadioBouton(
                  Text(
                    "à un temps précis",
                    style: textStyleGeneral,
                  ),
                  2,
                  choixVerbeTousTempsOuUnTemps, (value) {
            setState(() {
              choixVerbeTousTempsOuUnTemps = value!;
              boolChoixTempsFait = false;
              boolChoixTempsVerbePrecis = false;
            });
          }))
        ],
      )
    ];

    // Choix du temps pour un verbe en particulier
    List<Widget> ligneChoixTempsVerbePrecis = [
      Text(
        "Quel temps (forme) réviser ?",
        style: textStyleGeneral,
      ),
      Padding(
          padding: paddingGeneral,
          child: DropdownMenu<Temps>(
            menuHeight: 110,
            dropdownMenuEntries: choixVerbe
                .getTempsPossibles()
                .map((temps) =>
                    DropdownMenuEntry(value: temps, label: temps.nom))
                .toList(),
            onSelected: (temps) {
              setState(() {
                boolChoixTempsVerbePrecis = true;
                choixTemps = temps!;
              });
            },
          ))
    ];

    // Choix du temps
    List<Widget> ligneChoixTemps = [
      Text(
        "Quel temps (forme) réviser ?",
        style: textStyleGeneral,
      ),
      Padding(
          padding: paddingGeneral,
          child: DropdownMenu<Temps>(
            menuHeight: 250,
            dropdownMenuEntries: listeTemps
                .map((temps) =>
                    DropdownMenuEntry(value: temps, label: temps.nom))
                .toList(),
            onSelected: (temps) {
              setState(() {
                boolChoixTempsFait = true;
                choixTemps = temps!;
              });
            },
          ))
    ];

    // Choix du sous-groupe
    List<Widget> ligneChoixSousGroupe = [
      Text(
        "Quel sous-groupe réviser ?",
        style: textStyleGeneral,
      ),
      Padding(
          padding: paddingGeneral,
          child: DropdownMenu<SousGroupe>(
            menuHeight: 250,
            dropdownMenuEntries: listeSousGroupes
                .map((sousGroupe) =>
                    DropdownMenuEntry(value: sousGroupe, label: sousGroupe.nom))
                .toList(),
            onSelected: (sousGroupe) {
              setState(() {
                choixSousGroupe = sousGroupe!;
                boolChoixSousGroupe = true;
              });
            },
          ))
    ];

    // Réviser ce sous-groupe à tous les temps ?
    List<Widget> ligneChoixTousTempsGroupe = [
      Text(
        "Vous voulez réviser ce sous-groupe...",
        style: textStyleGeneral,
      ),
      // Ligne des radio buttons

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: RadioBouton(
                  Text("à tous les temps", style: textStyleGeneral),
                  1,
                  choixGroupeTousTempsOuUnTemps, (value) {
            setState(() {
              choixGroupeTousTempsOuUnTemps = value!;
              boolChoixTempsFait = true;
              boolChoixTempsGroupePrecis = false;
            });
          })),
          Expanded(
              child: RadioBouton(
                   Text(
                    "à un temps précis",
                    style: textStyleGeneral,
                  ),
                  2,
                  choixGroupeTousTempsOuUnTemps, (value) {
            setState(() {
              choixGroupeTousTempsOuUnTemps = value!;
              boolChoixTempsFait = false;
            });
          }))
        ],
      )
    ];

    // Choix du temps pour un sous-groupe précis
    List<Widget> ligneChoixTempsGroupePrecis = [
       Text(
        "Quel temps (forme) réviser ?",
        style: textStyleGeneral,
      ),
      Padding(
          padding: paddingGeneral,
          child: DropdownMenu<Temps>(
            menuHeight: 110,
            dropdownMenuEntries: choixSousGroupe == SousGroupeAucun()
                ? listeTemps
                    .map((temps) =>
                        DropdownMenuEntry(value: temps, label: temps.nom))
                    .toList()
                : choixSousGroupe.verbesDansCeGroupe[0]
                    .getTempsPossibles()
                    .map((temps) =>
                        DropdownMenuEntry(value: temps, label: temps.nom))
                    .toList(),
            onSelected: (temps) {
              setState(() {
                boolChoixTempsGroupePrecis = true;
                choixTemps = temps!;
              });
            },
          ))
    ];

    // Le premier choix n'a pas encore été fait

    toShow = premiereLigne;

    // L'utilisateur veut réviser quelque chose en particulier
    if (choixPrimaire == 2) {
      toShow += ligneChoixRevisionPrecise;

      // L'utilisateur veut réviser un verbe
      if (choixVerbeTempsGroupe == 1) {
        toShow += ligneChoixVerbe;

        // Le verbe a déjà été choisi
        if (boolDeroulantVerbeFait) {
          toShow += ligneChoixTousTempsVerbe;

          // L'utilisateur veut réviser le verbe à un temps en particulier
          if (choixVerbeTousTempsOuUnTemps == 2) {
            toShow += ligneChoixTempsVerbePrecis;
          }
        }
      }

      // L'utilisateur veut réviser un temps
      else if (choixVerbeTempsGroupe == 2) {
        toShow += ligneChoixTemps;
      }

      // L'utilisateur veut réviser un sous-groupe
      else if (choixVerbeTempsGroupe == 3) {
        toShow += ligneChoixSousGroupe;

        // Le sous-groupe a déjà été choisi
        if (boolChoixSousGroupe) {
          toShow += ligneChoixTousTempsGroupe;

          // L'utilisateur veut réviser le sous-groupe à un temps en particulier
          if (choixGroupeTousTempsOuUnTemps == 2) {
            toShow += ligneChoixTempsGroupePrecis;
          }
        }
      }
    }

    bool boolValidable = false;
    if (
        // Révision générale
        choixPrimaire == 1

            // un verbe en particulier à tous les temps
            ||
            (choixPrimaire == 2 &&
                choixVerbeTempsGroupe == 1 &&
                boolDeroulantVerbeFait &&
                choixVerbeTousTempsOuUnTemps == 1)

            // un verbe à un temps particulier
            ||
            (choixPrimaire == 2 &&
                choixVerbeTempsGroupe == 1 &&
                choixVerbeTousTempsOuUnTemps == 2 &&
                boolChoixTempsVerbePrecis)

            // un temps particulier
            ||
            (choixPrimaire == 2 &&
                choixVerbeTempsGroupe == 2 &&
                boolChoixTempsFait)

            // un sous-groupe particulier à tous les temps
            ||
            (choixPrimaire == 2 &&
                choixVerbeTempsGroupe == 3 &&
                boolChoixSousGroupe &&
                choixGroupeTousTempsOuUnTemps == 1)

            // un sous-groupe à un temps particulier
            ||
            (choixPrimaire == 2 &&
                choixVerbeTempsGroupe == 3 &&
                boolChoixSousGroupe &&
                choixGroupeTousTempsOuUnTemps == 2 &&
                boolChoixTempsGroupePrecis)) {
      boolValidable = true;
    }

    // Bouton "Valider"
    BoutonGros boutonValider =
        BoutonGros(text: "Valider", action: boolValidable ? lancer : null);

    return Padding(
      padding: paddingGeneral,
      child: ListView(shrinkWrap: false, children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
              ...toShow,
              Padding(
                padding: paddingGeneral,
                child: boutonValider,
              )])
            
      ]),
    );
  }

  void lancer() {
    // Charge la pub interstitielle qui sera affichée à la fin de l'exercice
    Pub.loadAdInterstitial();

    // Lancer une révision générale
    if (choixPrimaire == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ExerciceGeneral()));
    }

    // Un verbe en particulier à tous les temps
    if (choixPrimaire == 2 &&
        choixVerbeTempsGroupe == 1 &&
        boolDeroulantVerbeFait &&
        choixVerbeTousTempsOuUnTemps == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciceSurVerbes(
                    verbeAReviser: choixVerbe,
                    tempsAReviser: choixVerbe.getTempsPossibles(),
                    nbrQstDejaFaites: 0,
                  )));
    }

    // Un verbe en particulier à un temps en particulier
    else if (choixPrimaire == 2 &&
        choixVerbeTempsGroupe == 1 &&
        choixVerbeTousTempsOuUnTemps == 2 &&
        boolChoixTempsVerbePrecis) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciceSurVerbes(
                    verbeAReviser: choixVerbe,
                    tempsAReviser: [choixTemps],
                    nbrQstDejaFaites: 0,
                  )));
    }

    // Un temps particulier
    else if (choixPrimaire == 2 &&
        choixVerbeTempsGroupe == 2 &&
        boolChoixTempsFait) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExerciceSurTemps(temps: choixTemps, nbrQstDejaFaites: 0)));
    }

    // Un sous-groupe en particulier à tous les temps
    else if (choixPrimaire == 2 &&
        choixVerbeTempsGroupe == 3 &&
        boolChoixSousGroupe &&
        choixGroupeTousTempsOuUnTemps == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciceSurGroupesVerbaux(
                  sousGroupe: choixSousGroupe,
                  temps:
                      choixSousGroupe.verbesDansCeGroupe[0].getTempsPossibles(),
                  nbrQstDejaFaites: 0)));
    }

    // Un sous-groupe particulier à un temps particulier
    else if (choixPrimaire == 2 &&
        choixVerbeTempsGroupe == 3 &&
        boolChoixSousGroupe &&
        choixGroupeTousTempsOuUnTemps == 2 &&
        boolChoixTempsGroupePrecis) {
      SousGroupe sousGroupeAEnvoyer = SousGroupe();

      if (choixSousGroupe == SousGroupeAucun()) {
        for (var v in choixSousGroupe.verbesDansCeGroupe) {
          if (v.getTempsPossibles().contains(choixTemps)) {
            sousGroupeAEnvoyer.verbesDansCeGroupe.add(v);
          }
        }
      } else {
        sousGroupeAEnvoyer = choixSousGroupe;
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciceSurGroupesVerbaux(
                  sousGroupe: sousGroupeAEnvoyer,
                  temps: [choixTemps],
                  nbrQstDejaFaites: 0)));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/sous_groupes.dart';
import 'package:verbes_irreguliers_francais/data/temps.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';
import 'package:verbes_irreguliers_francais/types/types_containers.dart';
import 'package:verbes_irreguliers_francais/types/types_sous_groupes.dart';
import 'package:verbes_irreguliers_francais/types/types_temps.dart';
import 'package:verbes_irreguliers_francais/types/types_verbes.dart';

/*
 * Page sur laquelle l'utilisateur arrive quand il ouvre l'appli
 * 
 * Elle est composée d'une barre de recherche et d'une liste de boutons qui
 * permettent de consulter la conjugaison des verbes
 */

class ConsulterNV extends StatelessWidget {
  const ConsulterNV({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? ad = context.watch<ProviderAfficherAdBanner>().getAdBanner(context);

    return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          if (ad != null)
            SizedBox(
                height: 70,
                child: Padding(
                  padding: paddingGeneral,
                  child: ad,
                )),
          Expanded(child: Consulter())
        ]));
  }
}

class Consulter extends StatefulWidget {
  const Consulter({super.key});

  @override
  State<StatefulWidget> createState() => _ConsulterState();
}

enum _Selector { alphabet, temps, groupes }

class _ConsulterState extends State<Consulter> {
  List<Verbe> _liste = [];
  late _Selector selector;
  late Temps selectorTemps;
  List<DropdownMenuItem<Temps>> itemsTemps = [];
  late SousGroupe selectorSousGroupe;
  List<DropdownMenuItem<SousGroupe>> itempsSousGroupes = [];

  @override
  void initState() {
    _liste.addAll(listeVerbes);
    _liste = Verbe.trierOrdre(_liste);

    selector = _Selector.alphabet;
    selectorTemps = TempsPresent();
    selectorSousGroupe = SousGroupeAucun();

    itemsTemps = listeTemps
        .map((temps) => DropdownMenuItem(
              value: temps,
              child: _TextMenuItem(temps.nom),
            ))
        .toList();
    itempsSousGroupes = listeSousGroupes
        .map((groupe) => DropdownMenuItem(
              value: groupe,
              child: _TextMenuItem(groupe.nom),
            ))
        .toList();

    super.initState();
  }

  void _onChangeRecherche(String query) {
    if (query == "") {
      _liste.clear();
      _liste.addAll(listeVerbes);
      _liste = Verbe.trierOrdre(_liste);
      setState(() {});
    }

    _liste.clear();
    for (String verbe in listeVerbes.map((v) => v.infinitif)) {
      if (Verbe.supprimerAccentsEtMajuscules(verbe)
          .contains(Verbe.supprimerAccentsEtMajuscules(query))) {
        _liste.add(Verbe.verbFromString(verbe));
      }
    }

    _liste = Verbe.trierOrdre(_liste);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Barre de recherche

        Padding(
          padding: paddingGeneral,
          child: ContainerTitre(
              title: "Rechercher",
              childWidget: Padding(
                  padding: paddingGeneral,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (s) => _onChangeRecherche(s),
                        ),
                      ),
                      _getSelectors(),
                    ],
                  ))),
        ),

        // Liste des boutons
        Expanded(
          child: ListView(
            children: _getListeBoutons(),
          ),
        )
      ],
    ));
  }

  Widget _getSelectors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Principal
        DropdownButton(
          alignment: AlignmentDirectional.centerEnd,
          underline: SizedBox(),
          dropdownColor: Colors.white,
          onChanged: (selected) {
            setState(() {
              selector = selected ?? _Selector.alphabet;
            });
          },
          value: selector,
          items: [
            DropdownMenuItem(
                value: _Selector.alphabet,
                child: Text(
                  "Ordre alphabétique",
                  textAlign: TextAlign.right,
                  style: textStyleGeneral,
                )),
            DropdownMenuItem(
                value: _Selector.temps, child: _TextMenuItem("Temps")),
            DropdownMenuItem(
                value: _Selector.groupes, child: _TextMenuItem("Sous-groupes"))
          ],
        ),

        // Temps
        if (selector == _Selector.temps)
          DropdownButton(
              alignment: AlignmentDirectional.centerEnd,
              underline: SizedBox(),
              items: itemsTemps,
              value: selectorTemps,
              onChanged: (selected) {
                setState(() {
                  selectorTemps = selected ?? TempsPresent();
                });
              }),

        // Sous-groupes
        if (selector == _Selector.groupes)
          DropdownButton(
              alignment: AlignmentDirectional.centerEnd,
              underline: SizedBox(),
              items: itempsSousGroupes,
              value: selectorSousGroupe,
              onChanged: (selected) {
                setState(() {
                  selectorSousGroupe = selected ?? SousGroupeAucun();
                });
              })
      ],
    );
  }

  // Cette liste présente la lettre des verbes suivants avec eux :
  // A
  // Aller
  // Avoir
  // B
  // Boire
  List<Widget> _getListeBoutons() {
    List<Widget> toReturn = [];

    // Ordre alphabétique
    if (selector == _Selector.alphabet) {
      toReturn.addAll(_getBoutonsSelonListe(_liste));
    }

    // Temps
    else if (selector == _Selector.temps) {
      List<Verbe> listeRaccourcie = listeTemps
          .firstWhere((temps) => temps == selectorTemps)
          .verbeIrreguliersACeTemps
          .where((verbe) => _liste.contains(verbe))
          .toList();

      toReturn.addAll(_getBoutonsSelonListe(listeRaccourcie));
    }

    // Sous-groupes
    else {
      List<Verbe> listeRaccourcie = listeSousGroupes
          .firstWhere((sg) => sg == selectorSousGroupe)
          .verbesDansCeGroupe
          .where((verbe) => _liste.contains(verbe))
          .toList();

      toReturn.addAll(_getBoutonsSelonListe(listeRaccourcie));
    }

    return toReturn;
  }

  List<Widget> _getBoutonsSelonListe(List<Verbe> liste) {
    List<Widget> toReturn = [];
    String lettreEnCours = "";
    String lettreNouvelle = "";

    for (var verbe in liste) {
      // Récupère la première lettre du verbe
      lettreNouvelle = Verbe.supprimerAccentsEtMajuscules(verbe.infinitif)
          .split("")[0]
          .toUpperCase();

      if (lettreNouvelle != lettreEnCours) {
        lettreEnCours = lettreNouvelle;

        // Ajout de la grosse lettre
        toReturn.add(Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child:
              SizedBox(
                width: 16,
                child:
                  ShaderMask(
                  shaderCallback: (bounds) => gradientRougeRougeClair.createShader(Rect.fromLTWH(0, 0, 16.0, bounds.height)),
                  blendMode: BlendMode.srcIn,
                  child:
                    Text(
                      lettreEnCours,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  )),
            
            ));
      }

      // Ajout du bouton
      toReturn.add(Padding(
          padding: paddingEntreBoutonsInfinitif,
          child: BoutonInfinitif(verbe: verbe)));
    }

    return toReturn;
  }
}

class _TextMenuItem extends Text {
   _TextMenuItem(super.data)
      : super(textAlign: TextAlign.right, style: textStyleGeneral);
}

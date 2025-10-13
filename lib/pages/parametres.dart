import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/data/textes_menus.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';
import 'package:verbes_irreguliers_francais/types/types_containers.dart';

import '../data/data_pub.dart';
import '../initialize_screen.dart';
import '../main.dart';

enum PlusOuMoins {moins, plus}

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<StatefulWidget> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {

    List<Widget> toShow = [


      // Taille de police
      
      Padding(padding: paddingGeneral, child:
      
      ContainerTitre(title: "Taille de la police d'écriture", childWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () => changerTaillePolice(PlusOuMoins.moins), icon: Icon(Icons.remove)),
              Text(taillePolice.toString(), style: textStyleGeneral),
              IconButton(onPressed: () => changerTaillePolice(PlusOuMoins.plus), icon: Icon(Icons.add))
            ],
          ),

          Text("Il est recommandé de redémarrer l'application pour bien appliquer le changement de police dans toute l'application.", style: textStyleGeneral, textAlign: TextAlign.center,),

        ],
      ))
      
      ,),

      Padding(
        padding: paddingGeneral,
        child: ContainerClassique(child: textParametresEcrivezMoi),
      ),
      Padding(
        padding: paddingGeneral,
        child: ContainerTitre(
            title: "Me contacter", childWidget: textParametresContacts),
      ),
      Padding(
          padding: paddingGeneral,
          child: BoutonGros(
              text: "Revoir le tutoriel",
              action: () {
                introFaite = false;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingPage()));
              }))
    ];

    toShow.add(Padding(
      padding: paddingGeneral,
      child: BoutonGros(
          text:
              "Changer les règles de confidentialité\n(only for EEA countries)",
          action: () {
            ConsentInformation.instance.reset();
            dejaCharge = false;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const InitializeScreen(
                            targetWidget: HomePage(
                          index: 0,
                        ))));
          }),
    ));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
        foregroundColor: couleurTexteAppBar,
        backgroundColor: couleurAppBar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: couleurBackgroundGeneral,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: toShow,
          ),
        ],
      ),
    ));
  }

  
  void changerTaillePolice (PlusOuMoins plusOuMoins) {
    setState(() {
      if (plusOuMoins == PlusOuMoins.moins && taillePolice > taillePoliceMin) {
        taillePolice--;
      }

      else if (plusOuMoins == PlusOuMoins.plus && taillePolice < taillePoliceMax) {
        taillePolice++;
      }

      GestionMemoire.enregistrerTaillePolice();

      context.read<ProviderPolice>().update();
    });
  }
}

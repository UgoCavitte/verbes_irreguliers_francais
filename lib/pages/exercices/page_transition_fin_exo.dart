import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/pages/exercices/exos_corriges/modele_corrige.dart';

import '../../data/constantes.dart';
import '../../data/data_pub.dart';
import '../../types/types_boutons.dart';
import 'constantes_exos.dart';
import 'modele_page_finale.dart';

class PageTransitionFinExo extends Column {
  PageTransitionFinExo(
      {required BuildContext context,
      required List<ModeleCorrige> corriges,
      super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Padding(
                padding: paddingGeneral,
                child: richTextVousAvezReponduAToutesLesQuestions),
            const Spacer(),
            Container(
                padding: paddingGeneral,
                child: BoutonGros(
                    text: txtAppBarResultats,
                    action: () {
                      // Si l'utilisateur n'est pas premium
                      if (interstitialAd.isLoaded && !MyUser.isPremium) {
                        interstitialAd.show();
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModelePageFinale(contenuCorrige: corriges)));
                    }))
          ],
        );
}

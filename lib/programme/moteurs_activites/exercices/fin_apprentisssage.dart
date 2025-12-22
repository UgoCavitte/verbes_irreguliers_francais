import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/main.dart';
import 'package:verbes_irreguliers_francais/programme/composants/icon_check_animee.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/programme/constantes_apprentissages.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

import '../../../data/constantes.dart';
import '../../types/etape.dart';
import '../../types/module.dart';

class FinApprentissage extends Column {
  FinApprentissage(
      {super.key,
      required Etape etape,
      required Module module,
      required BuildContext context})
      : super(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const SizedBox(height: 70, child: IconCheckAnimee()),
              TextPaddAlign(
                  text: etape.type == TypeEtape.apprentissage
                      ? "Bravo ! Vous avez terminé cette étape d'apprentissage !"
                      : "Bravo ! Vous avez terminé cette étape de révision !"),
              const Spacer(),
              Container(
                  padding: paddingGeneral,
                  child: BoutonGros(
                      text: stringTerminerBouton,
                      action: () {
                        // Si l'utilisateur n'est pas premium
                        if (interstitialAd.isLoaded && !MyUser.isPremium) {
                          interstitialAd.show();
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage(
                                      index: 1,
                                      skipLoading: true,
                                    )),
                            (Route<dynamic> route) => false);
                      }))
            ]);
}

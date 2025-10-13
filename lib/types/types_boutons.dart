import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_pub.dart';
import 'package:verbes_irreguliers_francais/types/types_textes.dart';

import '../pages/afficher_verbe.dart';
import 'types_verbes.dart';

class BoutonInfinitif extends StatelessWidget {
  final Verbe verbe;

  const BoutonInfinitif({super.key, required this.verbe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientBleuBleuClair,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (_) => ProviderAfficherAdBanner(),
                        child: AfficherVerbe(verbe: verbe),
                      )));
        },
        child: TexteInfinitifBouton(text: verbe.infinitif),
      ),
    );
  }

  static ListView genererLesBoutonsInfinitif() {
    // Met les verbes dans l'ordre alphabétique
    listeVerbes.sort((a, b) => Verbe.supprimerAccentsEtMajuscules(a.infinitif)
        .compareTo(Verbe.supprimerAccentsEtMajuscules(b.infinitif)));

    List<Padding> listPadding = <Padding>[];
    for (Verbe verbe in listeVerbes) {
      listPadding.add(Padding(
        padding: paddingEntreBoutonsInfinitif,
        child: BoutonInfinitif(verbe: verbe),
      ));
    }

    ListView toReturn = ListView(
      padding: paddingEntreBoutonsInfinitif,
      children: [...listPadding],
    );

    return toReturn;
  }
}

class BoutonGros extends ElevatedButton {
  final String text;
  final VoidCallback? action;

  BoutonGros({required this.text, required this.action, super.key})
      : super(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
            onPressed: action,
            style: ElevatedButton.styleFrom(
                backgroundColor: bleu,
                foregroundColor: Colors.white,
                shape: const ContinuousRectangleBorder(side: BorderSide())));
}

class BoutonGrosGradientRouge extends StatelessWidget {
  final String text;
  final VoidCallback? action;

  const BoutonGrosGradientRouge(
      {super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientRougeRougeClair,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: action,
        child: TexteInfinitifBouton(text: text),
      ),
    );
  }
}

class BoutonGrosVert extends ElevatedButton {
  final String text;
  final VoidCallback? action;
  BoutonGrosVert({required this.text, required this.action, super.key})
      : super(
            child: Text(text),
            onPressed: action,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: vert,
                backgroundColor: vert,
                disabledForegroundColor: Colors.white,
                foregroundColor: Colors.white,
                shape: const ContinuousRectangleBorder(side: BorderSide())));
}

class BoutonGrosRouge extends ElevatedButton {
  final String text;
  final VoidCallback? action;
  BoutonGrosRouge({required this.text, required this.action, super.key})
      : super(
            child: Text(text),
            onPressed: action,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: rouge,
                backgroundColor: rouge,
                disabledForegroundColor: Colors.white,
                foregroundColor: Colors.white,
                shape: const ContinuousRectangleBorder(side: BorderSide())));
}

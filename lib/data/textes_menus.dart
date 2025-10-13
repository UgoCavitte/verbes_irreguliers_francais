import 'package:flutter/material.dart';

import 'constantes.dart';

// Paramètres
RichText textParametresEcrivezMoi = RichText(
  textAlign: TextAlign.justify,
  text: TextSpan(children: [
    TextSpan(
        style: textStyleGeneral,
        text:
            "Cette application est encore en développement. Seule une partie des fonctionnalités est disponible pour le moment. Les autres fonctionnalités apparaîtront au fur et à mesure des mises à jour.\n"),
    TextSpan(
        style: textStyleGeneral,
        text:
            "Si vous rencontrez le moindre problème, n'hésitez pas à me contacter pour que je puisse le corriger le plus rapidement possible.")
  ]),
);

RichText textParametresContacts = RichText(
  textAlign: TextAlign.center,
  text: TextSpan(children: [
    TextSpan(
        style: textStyleGeneral,
        text: "Telegram : @ucavitte / @francaisugo\n"),
    TextSpan(
        style: textStyleGeneral, text: "Mail : contact@ugocavitte.com")
  ]),
);

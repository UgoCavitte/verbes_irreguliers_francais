import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

// Page 1
// Bienvenue
const String introTitlePage1 = "Bienvenue !";
RichText introBodyPage1 = RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(style: textStyleGeneral, children: [
      TextSpan(
          text:
              "Bienvenue dans l'application \"Verbes irréguliers français\" !\n"),
      TextSpan(text: "Cette application permet aux utilisateurs de :\n"),
      TextSpan(
          text:
              " - consulter la conjugaison des verbes irréguliers de la langue française ;\n"),
      TextSpan(
          text:
              " - suivre un programme d'apprentissage des verbes irréguliers français (révisions comprises !) ;\n"),
      TextSpan(
          text:
              " - réviser la conjugaison des verbes irréguliers de la langue française de manière personnalisée.\n")
    ]));

// Page 2
// Page de recherche
const String introTitlePage2 = "Comment consulter la conjugaison d'un verbe ?";
RichText introBodyPage2 = RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(style: textStyleGeneral, children: [
      TextSpan(
          text: "Pour consulter la conjugaison d'un verbe, vous pouvez :\n"),
      TextSpan(
          text: " - soit cliquer sur un verbe parmi la liste affichée ;\n"),
      TextSpan(
          text:
              " - soit préciser votre recherche via la barre de recherche.\n"),
      TextSpan(
          text:
              "Seules les formes irrégulières ou particulières des verbes sont présentées. Les formes régulières ne le sont pas, puisque vous pouvez les déduire des règles.")
    ]));

// Page 3
// Apprentissage
const String introTitlePage3 =
    "Comment fonctionne l'onglet du programme d'apprentissage ?";
RichText introBodyPage3 = RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(style: textStyleGeneral, children: [
      TextSpan(
          text:
              "Le programme d'apprentissage comprend les fonctionnalités suivantes :\n"),
      TextSpan(
          text:
              " - apprendre les formes irrégulières des verbes concernés par chaque temps comprenant des irrégularités ;\n"),
      TextSpan(
          text:
              " - réviser selon le programme (des étapes de révision sont comprises dans le programme) ;\n"),
      TextSpan(
          text:
              " - réviser quotidiennement ce que vous avez appris auparavant (cette fonctionnalité se réinitialise chaque jour).\n"),
      TextSpan(
          text:
              "Remarquez que vous pouvez marquer manuellement des étapes comme faites en appuyant sur les cercles. Vous pouvez également marquer des modules entiers comme faits.")
    ]));

// Page 4
// Révision ancienne page
const String introTitlePage4 = "Comment faire des révisions personnalisées ?";
RichText introBodyPage4 = RichText(
  textAlign: TextAlign.justify,
  text: TextSpan(style: textStyleGeneral, children: [
    TextSpan(
        text:
            "Si vous voulez réviser de manière plus personnalisé, c'est possible grâce à cet onglet. Vous pouvez réviser :\n"),
    TextSpan(text: " - un verbe en particulier ;\n"),
    TextSpan(text: " - un sous-groupe de verbes particulier ;\n"),
    TextSpan(text: " - un temps (ou une forme) particulier.\n"),
    TextSpan(
        text:
            "Cet onglet est ancien, il sera mis à jour dans les prochaines semaines.")
  ]),
);

// Page 5
// Merci bonne chance
const String introTitlePage5 = "Merci et bonne chance !";
RichText introBodyPage5 = RichText(
  textAlign: TextAlign.justify,
  text: TextSpan(style: textStyleGeneral, children: [
    TextSpan(
        text:
            "Merci d'avoir téléchargé cette application. Je vous souhaite bonne chance dans votre apprentissage du français !\n"),
    TextSpan(
        text:
            "Si vous rencontrez le moindre problème, n'hésitez pas à me contacter :\n"),
    TextSpan(text: "Telegram : @ucavitte / @francaisugo\n"),
    TextSpan(text: "Mail : contact@ugocavitte.com\n\n"),
    TextSpan(
        text:
            "Vous pouvez relancer ce tutoriel à tout moment dans les paramètres.")
  ]),
);

/* ANCIENNE INTRO */

// Page 1
/*
const String introTitlePage1 = "Bienvenue !";
RichText introBodyPage1 = RichText(
    textAlign: TextAlign.justify,
    text: const TextSpan(style: TextStyle(color: Colors.black), children: [
      TextSpan(
          text:
              "Bienvenue dans l'application \"Verbes irréguliers français\" !\n"),
      TextSpan(text: "Cette application permet aux utilisateurs de :\n"),
      TextSpan(
          text:
              " - consulter la conjugaison des verbes irréguliers de la langue française ;\n"),
      TextSpan(
          text:
              " - réviser la conjugaison des verbes irréguliers de la langue française.\n")
    ]));*/

// Page 2
/*
const String introTitlePage2 = "Comment consulter la conjugaison d'un verbe ?";
RichText introBodyPage2 = RichText(
    textAlign: TextAlign.justify,
    text: const TextSpan(style: TextStyle(color: Colors.black), children: [
      TextSpan(
          text: "Pour consulter la conjugaison d'un verbe, vous pouvez :\n"),
      TextSpan(
          text:
              " - soit cliquer sur un verbe de la liste affichée sur la première page ;\n"),
      TextSpan(text: " - soit rechercher un verbe dans la barre de recherche.")
    ]));*/

// Page 3
/*
const String introTitlePage3 = "Page de conjugaison d'un verbe";
RichText introBodyPage3 = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(style: TextStyle(color: Colors.black), children: [
    TextSpan(
        text:
            "Seules les formes des temps auxquels le verbe est irrégulier sont affichées. Cela permet de limiter le volume et d'optimiser l'apprentissage.\n"),
    TextSpan(
        text:
            "Le sous-groupe de verbes irréguliers auquel le verbe en question appartient est indiqué entre parenthèses.")
  ]),
);*/

// Page 4
/*
const String introTitlePage4 = "Comment réviser ?";
RichText introBodyPage4 = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(style: TextStyle(color: Colors.black), children: [
    TextSpan(
        text:
            "Pour arriver au menu de révision, cliquez sur la page \"Réviser\" et sur le bouton du même nom.")
  ]),
);*/

// Page 5
/*
const String introTitlePage5 = "Comment lancer une révision ?";
RichText introBodyPage5 = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(style: TextStyle(color: Colors.black), children: [
    TextSpan(
        text:
            "L'application permet de réviser de manière générale, c'est-à-dire tous les verbes à toutes les formes, ou bien de réviser un aspect en particulier :\n"),
    TextSpan(text: " - un verbe ;\n"),
    TextSpan(text: " - un temps ;\n"),
    TextSpan(text: " - un sous-groupe de verbes irréguliers.\n")
  ]),
);*/

// Page 6
/*
const String introTitlePage6 = "Application encore en développement";
RichText introBodyPage6 = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(style: TextStyle(color: Colors.black), children: [
    TextSpan(
        text:
            "Cette application est encore en développement. Seule une partie des fonctionnalités est disponible pour le moment. Les autres fonctionnalités apparaîtront au fur et à mesure des mises à jour.\n"),
    TextSpan(
        text:
            "Si vous rencontrez le moindre problème, n'hésitez pas à me contacter pour que je puisse le corriger le plus rapidement possible.\n"),
    TextSpan(text: "Telegram : @ucavitte / @francaisugo\n"),
    TextSpan(text: "Mail : contact@ugocavitte.com\n\n"),
    TextSpan(
        text:
            "Vous pouvez relancer ce tutoriel à tout moment dans les paramètres.")
  ]),
);*/

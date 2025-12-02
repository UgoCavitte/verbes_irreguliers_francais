import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../types/types_verbes.dart';
import 'verbes.dart';

bool introFaite = true;

double taillePolice = 15;
const double taillePoliceMax = 24;
const double taillePoliceMin = 8;

const Color bleu = Color(0xff00049f);
const Color bleuClair = Colors.lightBlue;
const Color rouge = Color(0xffff3131);
const Color orange = Color(0xffe39830);
const Color vert = Colors.green;
const Color vertClair = Color(0xffcfffa6);
const Color grisClair = Color(0xffd3d3d3);
const int vertR = 76;
const int vertG = 175;
const int vertB = 80;

const LinearGradient gradientBleuBleuClair =
    LinearGradient(colors: [bleu, bleuClair]);
const LinearGradient gradientRougeRougeClair =
    LinearGradient(colors: [rouge, orange], begin: AlignmentGeometry.centerLeft, end: Alignment.centerRight);

// BottomNavyBar
const Color couleurBottomNavyBarFond = Colors.white;
const Color couleurBottomNavyBarActif = bleu;
const Color couleurBottomNavyBarInactif = bleu;
BottomNavyBarItem bottomNavyBarItemListe = BottomNavyBarItem(
    icon: iconeListe,
    title: const Text("Consulter"),
    activeColor: couleurBottomNavyBarActif,
    inactiveColor: couleurBottomNavyBarInactif);
BottomNavyBarItem bottomNavyBarItemApprendre = BottomNavyBarItem(
    icon: iconeApprendre,
    title: const Text("Apprendre"),
    activeColor: couleurBottomNavyBarActif,
    inactiveColor: couleurBottomNavyBarInactif);
BottomNavyBarItem bottomNavyBarItemReviser = BottomNavyBarItem(
    icon: iconeReviser,
    title: const Text("Réviser"),
    activeColor: couleurBottomNavyBarActif,
    inactiveColor: couleurBottomNavyBarInactif);
BottomNavyBarItem bottomNavyBarItemBoutique = BottomNavyBarItem(
    icon: iconeBoutique,
    title: const Text("Boutique"),
    activeColor: couleurBottomNavyBarActif,
    inactiveColor: couleurBottomNavyBarInactif);
BottomNavyBarItem bottomNavyBarItemStats = BottomNavyBarItem(
    icon: iconeStats,
    title: const Text("Statistiques"),
    activeColor: couleurBottomNavyBarActif,
    inactiveColor: couleurBottomNavyBarInactif);

/*
 * Énumérations
 */
enum StatutApprentissage { pasVu, vu, appris, consolide, aReviser }

// Pronoms personnel
const List<String> pronomsPersonnelsConsonne = [
  "Je",
  "Tu",
  "Il, elle, on",
  "Nous",
  "Vous",
  "Ils, elles"
];
const List<String> pronomsPersonnelsVoyelle = [
  "J'",
  "Tu",
  "Il, elle, on",
  "Nous",
  "Vous",
  "Ils, elles"
];
const List<String> pronomsPersonnelsConsonneSubjonctif = [
  "Que je",
  "Que tu",
  "Qu'il, qu'elle, qu'on",
  "Que nous",
  "Que vous",
  "Qu'ils, qu'elles"
];
const List<String> pronomsPersonnelsVoyelleSubjonctif = [
  "Que j'",
  "Que tu",
  "Qu'il, qu'elle, qu'on",
  "Que nous",
  "Que vous",
  "Qu'ils, qu'elles"
];
const List<String> pronomsPersonnelsImperatif = ["1", "2", "3"];
const List<String> pronomsPersonnelsParticipes = ["-"];
const List<String> pronomsPersonnelsImpersonnel = ["Il"];
const List<String> pronomsPersonnelsImpersonnelSubjonctif = ["Qu'il"];

/* 
 * Couleurs
 */

// Général
const Color couleurTexteBasique = bleu;
const Color couleurTextePronomsEtFormes = bleu;
const Color couleurBordure = bleu;
const Color couleurBoutonBackground = Color(0xFFe8e6e1);
const Color couleurSeparationPronomsFormes = Colors.grey;
const Color couleurBackgroundGeneral = Colors.white;
const Color couleurAppBar = bleu;
const Color couleurTexteAppBar = Colors.white;

// Apprendre et réviser
const Color couleurApprendreAppBar = bleu;
const Color couleurApprendreTexteAppBar = Colors.white;

// Styles de texte
TextStyle textStyleGeneral =
    TextStyle(color: couleurTexteBasique, fontSize: taillePolice);
TextStyle textStyleTitledContainer =
    TextStyle(color: couleurTexteBasique, fontSize: taillePolice * 1.2);
TextStyle textStyleMessageCentral = TextStyle(
    color: couleurTexteBasique, fontWeight: FontWeight.bold, fontSize: taillePolice * 1.8);

/*
Padding
 */
const EdgeInsets paddingTextePronomsEtFormes = EdgeInsets.fromLTRB(5, 0, 5, 0);
const EdgeInsets paddingEntreBoutonsInfinitif = EdgeInsets.all(10);
const EdgeInsets paddingGeneral = EdgeInsets.all(10);
const EdgeInsets paddingCardConjugaison = EdgeInsets.all(10);
const EdgeInsets paddingEntreLignesTexteUser = EdgeInsets.fromLTRB(10, 2, 5, 2);

// BoxDecoration
BoxDecoration boxDecorationBasique = BoxDecoration(
  border: Border.all(color: couleurBordure, width: 3),
);
BoxDecoration boxDecorationVerte = BoxDecoration(
  border: Border.all(color: vert, width: 3),
);
BoxDecoration boxDecorationRouge = BoxDecoration(
  border: Border.all(color: rouge, width: 3),
);

// Icones etc
const Icon iconeRechercher = Icon(Icons.search);
const Icon iconeParametres = Icon(Icons.settings);
const Icon iconeListe = Icon(Icons.search);
const Icon iconeBoutique = Icon(Icons.shopping_cart);
const Icon iconeStats = Icon(Icons.account_circle_rounded);
const Icon iconeApprendre = Icon(Icons.edit_note);
const Icon iconeReviser =
    Icon(Icons.replay); // pour l'instant seulement pour réviser

// Liste des verbes
List<Verbe> listeVerbes = <Verbe>[
  // E*er é*er
  Acheter(),
  Ceder(),
  Lever(),
  SeLever(),
  Peser(),
  SePeser(),
  Geler(),

  // Appeler, jeter
  Appeler(),
  Jeter(),
  Rejeter(),
  Projeter(),

  // Verbes en -evoir
  Devoir(),
  Recevoir(),
  Decevoir(),
  Apercevoir(),

  // Verbes en -enir
  Tenir(),
  Appartenir(),
  Retenir(),
  Detenir(),
  Obtenir(),
  Soutenir(),
  Venir(),
  Convenir(),
  Devenir(),
  Prevenir(),
  Revenir(),
  Parvenir(),
  SeSouvenir(),

  // Verbes en -indre
  Peindre(),
  Craindre(),
  SePlaindre(),
  Plaindre(),
  Eteindre(),
  Joindre(),
  Rejoindre(),
  Atteindre(),

  // Verbes en -oudre
  Coudre(),
  Moudre(),

  // Verbes en -uire
  Conduire(),
  Cuire(),
  Nuire(),
  Luire(),
  Deduire(),
  Reduire(),
  Detruire(),
  Produire(),
  Traduire(),
  Construire(),
  Introduire(),
  Seduire(),

  // Verbes très irréguliers
  Avoir(),
  Etre(),
  Vouloir(),
  Aller(),
  Pouvoir(),
  Savoir(),
  Falloir(),
  Pleuvoir(),
  Faire(),
  Mourir(),
  Valoir(),
  Battre(),
  Conclure(),
  Boire(),
  Croire(),
  Dormir(),
  Lire(),
  Naitre(),
  Plaire(),
  Resoudre(),
  Rire(),
  Sourire(),
  Sentir(),
  Servir(),
  Sortir(),
  Suivre(),
  Suffire(),
  SeTaire(),
  Vaincre(),
  Convaincre(),
  Vivre(),
  Survivre(),
  Cueillir(),
  Accueillir(),
  Courir(),
  Parcourir(),
  Voir(),
  Prevoir(),
  Envoyer(),
  Partir(),
  SAsseoir(),

  // Dire et composés
  Dire(),
  Interdire(),
  Redire(),
  Predire(),
  Maudire(),

  // Écrire et composés
  Ecrire(),
  Inscrire(),
  Reecrire(),
  Decrire(),

  // Prendre et composés
  Prendre(),
  Comprendre(),
  Apprendre(),
  Surprendre(),

  // Mettre et composés
  Mettre(),
  Promettre(),
  Permettre(),
  Transmettre(),
];

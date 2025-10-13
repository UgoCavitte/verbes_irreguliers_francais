// Constantes relatives à la génération des questions
import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

const int gnrExoNbrTentativesAvantEchec = 50;

// Constantes relatives aux nombres de questions
// Exos sur les verbes
const int exoNbrQstVFVerbe = 4;
const int exoNbrQstTrouveParmiVerbe = 4;
const int exoNbrQstRemplirEntierVerbe = 4;
int exoNbrTotalVerbe =
    exoNbrQstVFVerbe + exoNbrQstTrouveParmiVerbe + exoNbrQstRemplirEntierVerbe;

// Exos sur les groupes verbaux
const int exoNbrQstVFGroupe = 4;
const int exoNbrQstTrouveParmiGroupe = 4;
const int exoNbrQstRemplirEntierGroupe = 4;
int exoNbrTotalGroupe = exoNbrQstVFGroupe +
    exoNbrQstTrouveParmiGroupe +
    exoNbrQstRemplirEntierGroupe;

// Exos sur les temps
const int exoNbrQstVFTemps = 4;
const int exoNbrQstTrouveParmiTemps = 4;
const int exoNbrQstRemplirEntierTemps = 4;
int exoNbrTotalTemps =
    exoNbrQstVFTemps + exoNbrQstTrouveParmiTemps + exoNbrQstRemplirEntierTemps;

// Exos général
const int exoNbrQstGeneralVF = 6;
const int exoNbrQstGeneralTrouveParmi = 6;
const int exoNbrQstGeneralRemplirEntier = 6;
int exoNbrTotalGeneral = exoNbrQstGeneralVF +
    exoNbrQstGeneralTrouveParmi +
    exoNbrQstGeneralRemplirEntier;

// Constantes TextStyle
const TextStyle textStyleCompteQuestions =
    TextStyle(fontWeight: FontWeight.bold);

// Constantes pour les textes
const String txtAppBarReviser = "Réviser";
const String exosTxtVrai = "Vrai";
const String exosTxtFaux = "Faux";
const String exosTxtSuivant = "Suivant";
const String exosTxtBonneReponse = "Bonne réponse !";
const String exosTxtMauvaiseReponse = "Mauvaise réponse !";
const String exosTxtValider = "Valider";
const String txtAppBarResultats = "Résultats";
const String txtNoteFinale = "Note finale :";
const String txtLaBonneFormeEtait = "La bonne forme était :";
const String txtIlFallaitRepondre = "Il fallait répondre :";
const String txtQuitter = "Quitter";
const String txtLeTempsProposeEtait = "La forme proposée était";

RichText richTextVousAvezReponduAToutesLesQuestions = RichText(
    textAlign: TextAlign.center,
    text:  TextSpan(
        text:
            "Vous avez répondu à toutes les questions !\nAppuyez sur le bouton pour voir les résultats",
        style: textStyleMessageCentral));

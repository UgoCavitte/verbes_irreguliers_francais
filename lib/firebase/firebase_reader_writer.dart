import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/pages/boutique.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';

/*
 * Ce fichier interagit avec la base de données Firebase
 * 
 * Elle a deux fonctions :
 * - inscrire les nouveaux achats ;
 * - vérifier qu'un utilisateur premium est bel et bien premium.
 * 
 * L'inscription d'un achat se fait lors de la validation de l'achat (statut
 * "purchased")
 * 
 * La vérification se fait en deux étapes :
 * - une première fois avec une revérification avec Google
 * - les fois suivantes sans Google
 * Si le paiement n'est pas vérifié dans la base de données, il est vérifié via
 * Google est inscrit dans la base de données (ça peut arriver si une personne
 * a fait un achat avant l'intégration de la base de données)
 */

const String _collectionPremiumUsers = "premium_users_verbes";
const String _transactionDate = "transactionDate";
const String _purchaseId = "purchaseId";
const String _productId = "productId";
const String _verificationData = "verificationData";
const String _source = "source";
const String _userId = "userId";
const String _userEmail = "email";

abstract class FirebaseReaderWriter {
  // Cette fonction est appelée uniquement quand l'achat a le statut "purchased"
  // L'achat a ce statut uniquement lors du paiement (donc une seule fois)
  static void writeToBase(
      {required PurchaseDetails purchaseToWrite, required User? user}) {
    debugPrintThrottled("[AppCode] -> Writing to database");
    if (user != null) {
      FirebaseFirestore.instance
          .collection(_collectionPremiumUsers)
          .doc(user.uid)
          .set({
        _transactionDate: purchaseToWrite.transactionDate,
        _purchaseId: purchaseToWrite.purchaseID,
        _productId: purchaseToWrite.productID,
        _verificationData:
            purchaseToWrite.verificationData.serverVerificationData,
        _source: purchaseToWrite.verificationData.source,
        _userId: user.uid,
        _userEmail: user.email,
      });
    } else {
      debugPrintThrottled(
          "[AppCode] -> User was null, writing to database was aborted");
    }
  }

  /*
   * Cette fonction est appelée quand l'utilisateur lance l'application avec le
   * statut premium pour vérifier s'il ne fraude pas
   * Si la base ne contient pas les données, on vérifie via Google et, si Google
   * confirme l'achat, alors on inscrit ; sinon on retire le statut de premium
   */
  static Future<void> verifyFromBase({required User? user}) async {
    if (user != null) {
      // Récupération du document
      DocumentSnapshot<Map<String, dynamic>> dataFromBase =
          await FirebaseFirestore.instance
              .collection(_collectionPremiumUsers)
              .doc(user.uid)
              .get();

      // Vérification du contenu

      if (!dataFromBase.exists) {
        _userDidNotExist(user: user);
      } else {
        Map<String, dynamic>? lu = dataFromBase.data();
        if (lu == null) {
          _userDidNotExist(user: user);
        }

        // En principe, tout doit coller, mais on vérifie quand même :
        // - l'ID de l'utilisateur
        // - l'ID du produit
        else if (lu[_productId] == vipId && lu[_userId] == user.uid) {
          debugPrintThrottled("[AppCode] -> User was verified successfuly");
          // Tout va bien, on remet le statut à premium au cas où
          MyUser.isPremium = true;
          GestionMemoire.enregistrerStatut();
        }
      }

      return;
    } else {
      debugPrintThrottled(
          "[AppCode] -> User was null, verifying from database was aborted");
      return;
    }
  }

  static late StreamSubscription<List<PurchaseDetails>> subscription;
  static void _closeSubscription() {
    subscription.cancel();
  }

  // Cette fonction ajoute les données à la base si elles étaient inexistantes
  static void _userDidNotExist({required User user}) async {
    debugPrintThrottled(
        "[AppCode] -> User was not found in database. Checking data from Google Play before writing to database");
    // ETAPE 1 - On supprime les privilèges avant la vérification
    MyUser.isPremium = false;
    GestionMemoire.enregistrerStatut();

    // ETAPE 2 - D'abord, il faut vérifier que le paiement existe bien chez Google
    List<PurchaseDetails> purchases = [];

    subscription = BoutiqueState.iap.purchaseStream.listen((data) {
      debugPrintThrottled(
          "[AppCode] -> Data about purchases was retrieved for Google Play");
      purchases.addAll(data);

      // ETAPE 3
      for (var achat in data) {
        // On remet le statut premium si c'est vérifié
        if (achat.productID == vipId) {
          if (achat.pendingCompletePurchase) {
            InAppPurchase.instance.completePurchase(achat);
          }
          MyUser.isPremium = true;
          GestionMemoire.enregistrerStatut();
        }
        // Puis on inscrit en mémoire
        writeToBase(purchaseToWrite: achat, user: user);
      }

      _closeSubscription();
    });

    BoutiqueState.iap.restorePurchases();
    // Suite dans le stream
  }
}

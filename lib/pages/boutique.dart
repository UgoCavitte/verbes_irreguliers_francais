import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/firebase/firebase_notifier.dart';
import 'package:verbes_irreguliers_francais/firebase/firebase_reader_writer.dart';
import 'package:verbes_irreguliers_francais/firebase/login_page.dart';
import 'package:verbes_irreguliers_francais/firebase_options.dart';
import 'package:verbes_irreguliers_francais/programme/composants/text_padd_align.dart';
import 'package:verbes_irreguliers_francais/types/types_boutons.dart';

// https://www.youtube.com/watch?v=NWbkKH-2xcQ

const String vipId = 'verbes_vip_1';

bool initialisationBoutique = false;

GlobalKey boutiqueKey = GlobalKey();

class Boutique extends StatefulWidget {
  const Boutique({required GlobalKey key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BoutiqueState();
}

class BoutiqueState extends State<Boutique> {
  // Connexion à l'interface
  static InAppPurchase iap = InAppPurchase.instance;

  // Disponible ?
  static bool available = true;

  // Produits
  static List<ProductDetails> products = [];

  // Achats passés
  static List<PurchaseDetails> purchases = [];

  // Listener
  static late StreamSubscription<List<PurchaseDetails>> subscription;

  void reload() async {
    await initialize();
    setState(() {});
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  static bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var firebaseNotifier = context.watch<FirebaseNotifier>();

    if (!firebaseNotifier.loggedIn) {
      return LoginPage(reload: reload);
    }

    // Le magasin est en cours d'initialisation
    if (isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextPaddAlign(
            text: "Chargement du magasin",
          )),
          const Expanded(
              child: Padding(
            padding: paddingGeneral,
            child: CircularProgressIndicator(
              color: bleu,
            ),
          )),
        ],
      );
    }

    // L'initialisation est faite
    else {
      // IAP n'a pas abouti
      if (!available) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextPaddAlign(
              text:
                  "La boutique n'est pas disponible. Vérifiez votre connexion internet.",
            ),
          ],
        );
      }

      // IAP a abouti
      else {
        User? currentUser = FirebaseAuth.instance.currentUser;

        return SafeArea(
            child: Column(
          children: [
            // Titre
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              child: const Text(
                "Boutique",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: bleu),
                textAlign: TextAlign.center,
              ),
            ),

            // Article
            for (var prod in products)
              // A acheté
              if (_hasPurchased(prod.id) != null || MyUser.isPremium) ...[
                _ContainerAchat(prod: prod, dejaAchete: true)
              ]
              // Doit acheter
              else ...[
                _ContainerAchat(
                  prod: prod,
                  dejaAchete: false,
                )
              ],

            const Spacer(),

            Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        top: BorderSide(color: bleu, width: 3))),
                child: Row(
                  children: [
                    // Info sur l'utilisateur
                    Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPaddAlign(
                                padding: paddingEntreLignesTexteUser,
                                text: currentUser != null
                                    ? currentUser.displayName ?? "Anonyme"
                                    : "Utilisateur non connecté"),
                            TextPaddAlign(
                                padding: paddingEntreLignesTexteUser,
                                text: currentUser != null
                                    ? currentUser.email ?? "Email inconnu"
                                    : "Utilisateur non connecté"),
                            if (MyUser.isPremium)
                              TextPaddAlign(
                                  padding: paddingEntreLignesTexteUser,
                                  text: "Utilisateur premium")
                          ],
                        )),
                    // Bouton de déconnexion
                    Expanded(
                        flex: 7,
                        child: Padding(
                            padding: paddingGeneral,
                            child: BoutonGros(
                              text: 'Se déconnecter',
                              action: () async {
                                firebaseNotifier.loggedIn = false;
                                await FirebaseAuth.instance.signOut();
                                FirebaseAuth.instance
                                    .setPersistence(Persistence.NONE);
                                setState(() {});
                              },
                            )))
                  ],
                ))
          ],
        ));
      }
    }
  }

  static Future<void> initialize() async {
    // Disponible ?
    available = await iap.isAvailable();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if (available) {
      subscription = iap.purchaseStream.listen((data) {
        purchases.addAll(data);
        _verifyPurchases();

        if (boutiqueKey.currentState?.mounted == true) {
          boutiqueKey.currentState?.setState(() {});
        }
      });

      await _getProducts();
      await FirebaseReaderWriter.verifyFromBase(
          user: FirebaseAuth.instance.currentUser);

      isLoading = false;

      if (boutiqueKey.currentState?.mounted == true) {
        boutiqueKey.currentState?.setState(() {});
      }
    }
    return Future.delayed(const Duration(seconds: 1));
  }

  // Validates purchase

  // Gets all products available for sale
  static Future<void> _getProducts() async {
    Set<String> ids = {vipId};
    ProductDetailsResponse response = await iap.queryProductDetails(ids);

    products = response.productDetails;

    if (boutiqueKey.currentState?.mounted == true) {
      boutiqueKey.currentState?.setState(() {});
    }
  }

  static PurchaseDetails? _hasPurchased(String productID) {
    try {
      return purchases
          .firstWhere((purchase) => purchase.productID == productID);
    } catch (e) {
      return null;
    }
  }

  static void _verifyPurchases() {
    // Il n'y a qu'un seul produit, donc pas besoin de faire des listes
    PurchaseDetails? purchase = _hasPurchased(vipId);

    if (purchase != null && (purchase.status == PurchaseStatus.purchased)) {
      MyUser.isPremium = true;
      iap.completePurchase(purchase);
      GestionMemoire.enregistrerStatut();
      FirebaseReaderWriter.writeToBase(
          purchaseToWrite: purchase, user: FirebaseAuth.instance.currentUser);
    } else if (purchase != null) {
      MyUser.isPremium = false;
      GestionMemoire.enregistrerStatut();
    }
  }

  static void buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
}

class _ContainerAchat extends Container {
  final ProductDetails prod;
  final bool dejaAchete;
  _ContainerAchat({required this.prod, required this.dejaAchete})
      : super(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(3)),
            padding: paddingGeneral,
            margin: paddingGeneral,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prod.title,
                          style: textStyleGeneral,
                        ),
                        const Text(""),
                        Text(
                          prod.description,
                          style: textStyleGeneral,
                        ),
                        const Text(""),
                        Text("${prod.price} ${prod.currencySymbol}")
                      ],
                    )),
                const Spacer(flex: 1),
                Expanded(
                    flex: 4,
                    child: !dejaAchete
                        ? BoutonGros(
                            text: "Acheter",
                            action: () => BoutiqueState.buyProduct(prod))
                        : TextPaddAlign(
                            text: "Déjà acheté !",
                            style: const TextStyle(color: rouge, fontSize: 15),
                          ))
              ],
            ));
}

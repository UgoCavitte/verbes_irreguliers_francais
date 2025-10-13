import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbes_irreguliers_francais/data/data_user.dart';

MyInterstitialAd interstitialAd = MyInterstitialAd();
const adUnitIdInterstitial = "ca-app-pub-2601867806541576/5516030103";

late BannerAd bannerAd;
const adUnitIdBanner = "ca-app-pub-2601867806541576/6095743905";
const AdSize bannerSize = AdSize(width: 320, height: 50);

/*
 * Le boolén est passé à false quand la pub est affichée
 * Il faut donc vérifier qu'il est bien à false avant de lancer le chargement
 * d'une nouvelle pub pour éviter de surcharger le serveur en demandes et de
 * recevoir des refus
 */

class MyInterstitialAd {
  late InterstitialAd interstitialAd;
  bool isLoaded = false;

  Future<void> show() {
    isLoaded = false;
    return interstitialAd.show();
  }
}

abstract class Pub {
  // INTERSTITIAL
  static void loadAdInterstitial() {
    // Ne fonctionne pas si l'utilisateur est premium
    if (!interstitialAd.isLoaded && !MyUser.isPremium) {
      InterstitialAd.load(
          adUnitId: adUnitIdInterstitial,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
            interstitialAd.isLoaded = true;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint("$ad loaded.");
            interstitialAd.interstitialAd = ad;
          }, onAdFailedToLoad: (LoadAdError error) {
            debugPrint("InterstitialAd failed to load: $error");
          }));
    }
  }

  // BANNER
  static Future<void> loadAdBanner(BuildContext context) async {
    // Rien de tout ça ne se lance si l'utilisateur est premium
    if (!MyUser.isPremium) {
      bannerAd = BannerAd(
        adUnitId: adUnitIdBanner,
        request: const AdRequest(),
        size: bannerSize,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('[Appcode] -> $ad loaded.');
            context.read<ProviderAfficherAdBanner>().bannerLoaded();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, error) {
            debugPrint('[Appcode] -> BannerAd failed to load: $error');

            // Dispose the ad here to free resources.
            ad.dispose();
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},
        ),
      )..load();
    }
  }
}

enum PubStatut { unloaded, loading, loaded }

class ProviderAfficherAdBanner with ChangeNotifier {
  PubStatut statut = PubStatut.unloaded;

  Widget? getAdBanner(BuildContext context) {
    if (MyUser.isPremium) {
      return null;
    }

    // Si la bannière n'a pas été chargée
    if (statut == PubStatut.unloaded) {
      Pub.loadAdBanner(context);
      statut = PubStatut.loading;
      return SizedBox(
        child: Text("Loading ad"),
      );
    }

    if (statut == PubStatut.loading) {
      return SizedBox(
        child: Text("Loading ad"),
      );
    }

    // Si la bannière a été chargée

    statut = PubStatut.unloaded;
    debugPrintStack(label: "[App] -> showing banner");
    return AdWidget(ad: bannerAd);
  }

  void bannerLoaded() {
    debugPrintStack(label: "[App] notified");
    statut = PubStatut.loaded;
    notifyListeners();
  }
}

late final SharedPreferencesAsync memoire;
bool dejaCharge = false;

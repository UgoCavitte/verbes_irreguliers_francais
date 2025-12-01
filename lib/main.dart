import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbes_irreguliers_francais/data/gestion_memoire.dart';
import 'package:verbes_irreguliers_francais/data/textes_introduction.dart';
import 'package:verbes_irreguliers_francais/firebase/firebase_notifier.dart';
import 'package:verbes_irreguliers_francais/initialize_screen.dart';
import 'package:verbes_irreguliers_francais/pages/boutique.dart';
import 'package:verbes_irreguliers_francais/pages/consulter.dart';
import 'package:verbes_irreguliers_francais/pages/reviser_menu.dart';
import 'package:verbes_irreguliers_francais/pages/stats_page.dart';
import 'package:verbes_irreguliers_francais/programme/page_apprendre.dart';
import 'package:verbes_irreguliers_francais/types/type_dots.dart';
import 'data/constantes.dart';
import 'data/data_initialisation.dart';
import 'data/data_pub.dart';
import 'pages/parametres.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  memoire = SharedPreferencesAsync();

  await dotenv.load(fileName: "assets/.env");

  // Charge la taille de police
  await GestionMemoire.chargerTaillePolice();

  // Vérifie si la personne a déjà vu l'écran d'introduction
  if (await memoire.containsKey("introFaite")) {
    await memoire.getBool("introFaite").then((value) async {
      introFaite = value ?? false;
    });
  }

  // Si l'intro est déjà passée, on passe directement à la page principale
  // Sinon, on affiche l'intro
  runApp(
    
    ChangeNotifierProvider(create: (_) => ProviderPolice(), child: MaterialApp(
    title: "Verbes irréguliers français",
    home: introFaite
        ? const HomePage(
            index: 0,
          )
        : const OnBoardingPage(),
    debugShowCheckedModeBanner: false,
  ))
    
    );
}

// Écran d'introduction
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  // Ce qui se passe à la fin de l'écran d'introduction
  void _onIntroEnd(BuildContext context) {
    // Inscrit en mémoire le fait que l'écran a déjà été visionné
    memoire.setBool("introFaite", true);

    // Passe à la page d'accueil
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => const HomePage(
                index: 0,
              )),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: couleurBackgroundGeneral,
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Finir', style: TextStyle(fontWeight: FontWeight.w600)),
      safeAreaList: const [true, true, true, true],
      pages: [
        // Page 1 -> Bienvenue
        PageViewModel(
            title: introTitlePage1,
            bodyWidget: introBodyPage1,
            image: _buildImage("image_page_1.png"),
            decoration: pageDecoration),
        // Page 2 -> Consulter la conjugaison d'un verbe
        PageViewModel(
            title: introTitlePage2,
            bodyWidget: introBodyPage2,
            image: _buildImage("image_page_2.png"),
            decoration: pageDecoration),
        // Page 3 -> Programme d'apprentissage
        PageViewModel(
            title: introTitlePage3,
            bodyWidget: introBodyPage3,
            image: _buildImage("image_page_3.png"),
            decoration: pageDecoration),
        // Page 4 -> Ancien menu de révision
        PageViewModel(
            title: introTitlePage4,
            bodyWidget: introBodyPage4,
            image: _buildImage("image_page_4.png"),
            decoration: pageDecoration),
        // Page 5 -> Merci !
        PageViewModel(
            title: introTitlePage5,
            bodyWidget: introBodyPage5,
            decoration: pageDecoration),
      ],
    );
  }
}

// Page principale après l'écran d'introduction
class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  final int index;

  const HomePage({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();    
    _selectedIndex = widget.index;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    context.watch<ProviderPolice>();

    // Charger les données inscrites en mémoire

    // Initalise la boutique et Firebase
    if (!initialisationBoutique) {
      BoutiqueState.initialize().then((_) async {
        FirebaseMessaging messaging = FirebaseMessaging.instance;

        await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        setState(() {
          initialisationBoutique = true;
        });
      });

      return LoadingLancement.screen(EtapeLancement.boutique);
    }

    if (!DataInitialisation.initialisationFaite) {
      DataInitialisation.initialiserData().then((_) {
        setState(() {
          DataInitialisation.initialisationFaite = true;
        });
      });

      return LoadingLancement.screen(EtapeLancement.memoire);
    }

    //////////////////////////////////////////////////////////////////////
    /// TOUT LE BORDEL POUR LOCALISER L'UTILISATEUR ETC
    //////////////////////////////////////////////////////////////////////

    else {
      // L'utilisateur n'a pas encore consenti ?
      if (!dejaCharge) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: InitializeScreen(
              targetWidget: HomePage(
            index: 0,
          )),
        );
      }

      //////////////////////////////////////////////////////////////////////
      /// FIN
      //////////////////////////////////////////////////////////////////////

      return Scaffold(
          appBar: AppBar(
            title: const Text("Les verbes irréguliers"),
            centerTitle: true,
            foregroundColor: couleurTexteAppBar,
            backgroundColor: couleurAppBar,
            actions: [
              IconButton(
                icon: iconeParametres,
                tooltip: "Paramètres",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Parametres()));
                },
              )
            ],
          ),
          backgroundColor: couleurBackgroundGeneral,
          body: PageView(controller: _pageController, children: [
            // Page de recherche
            ChangeNotifierProvider(
              create: (_) => ProviderAfficherAdBanner(),
              child: ConsulterNV(),
            ),

            // Page avec le programme d'apprentissage
            // const PageApprendre(),
            ChangeNotifierProvider(create: (_) => ProviderAfficherAdBanner(), child: PageApprendre(),),

            // Suite
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (_) => ProviderAfficherAdBanner())
              ],
              child: ReviserMenuNv(),
            ),
            MultiProvider(
              providers: [
                ChangeNotifierProvider<FirebaseNotifier>(
                    create: (_) => FirebaseNotifier())
              ],
              child: Boutique(key: boutiqueKey),
            ),
            ChangeNotifierProvider(
              create: (_) => ProviderAfficherAdBanner(),
              child: StatsPage(),
            ),
          ]),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: couleurBottomNavyBarFond,
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(index);
            }),
            items: [
              bottomNavyBarItemListe,
              bottomNavyBarItemApprendre,
              bottomNavyBarItemReviser,
              bottomNavyBarItemBoutique,
              bottomNavyBarItemStats,
            ],
          ));
    }
  }
}

abstract class LoadingLancement {
  static Scaffold screen(EtapeLancement etape) {
    String texte = "";
    int ordre = 0;
    const int dotsCount = 3;

    switch (etape) {
      case EtapeLancement.boutique:
        texte = "Lecture des données du serveur...";
        ordre = 0;
        break;
      case EtapeLancement.memoire:
        texte = "Lecture des données inscrites en mémoire...";
        ordre = 1;
        break;
      case EtapeLancement.gdpr:
        texte = "Vérification de l'application du RGPD...";
        ordre = 2;
        break;
    }

    return Scaffold(
        backgroundColor: couleurBackgroundGeneral,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: paddingGeneral,
              child: Text(
                texte,
                style: textStyleGeneral,
              ),
            ),
            Padding(
                padding: paddingGeneral,
                child: MyDots(
                  dotsCount: dotsCount,
                  position: ordre,
                ))
          ],
        )));
  }
}

class ProviderPolice with ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

enum EtapeLancement { boutique, memoire, gdpr }

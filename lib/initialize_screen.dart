import 'package:flutter/material.dart';
import 'package:verbes_irreguliers_francais/main.dart';

import 'initialization_helper.dart';

class InitializeScreen extends StatefulWidget {
  final Widget targetWidget;

  const InitializeScreen({super.key, required this.targetWidget});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  final _initializationHelper = InitializationHelper();

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingLancement.screen(EtapeLancement.gdpr);
  }

  Future<void> _initialize() async {
    final navigator = Navigator.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializationHelper.initialize();
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => widget.targetWidget),
      );
    });
  }
}

import 'dart:math';

import 'types_verbes.dart';

class SousGroupe {
  String nom = "default";
  List<Verbe> verbesDansCeGroupe = [];

  SousGroupe();

  Verbe verbeRandom({required Random random}) {
    return verbesDansCeGroupe[random.nextInt(verbesDansCeGroupe.length)];
  }

  @override
  bool operator ==(Object other) =>
      other is SousGroupe &&
      other.runtimeType == runtimeType &&
      other.nom == nom;

  @override
  int get hashCode => nom.hashCode;
}

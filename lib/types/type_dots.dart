import 'package:dots_indicator/dots_indicator.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

class MyDots extends DotsIndicator {
  MyDots({super.key, required super.dotsCount, required int position})
      : super(
            position: position.toDouble(),
            decorator: const DotsDecorator(activeColor: rouge));
}

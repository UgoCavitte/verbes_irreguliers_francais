import 'package:flutter/widgets.dart';
import 'package:verbes_irreguliers_francais/data/constantes.dart';

class TextPaddAlign extends Padding {
  TextPaddAlign(
      {super.key,
      required String text,
      TextStyle? style,
      super.padding = paddingGeneral})
      : super(
            child: Text(
          text,
          style: style ?? textStyleGeneral,
          textAlign: TextAlign.center,
        ));
}

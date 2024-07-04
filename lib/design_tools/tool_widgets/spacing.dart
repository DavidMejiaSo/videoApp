import 'package:flutter/material.dart';

class Spacing {
  static SizedBox vertical(double height) {
    //Los métodos en la clase Spacing se declaran
    //como estáticos para que puedan ser accedidos sin
    //necesidad de crear una instancia de la clase.
    return SizedBox(height: height); //------>Espaciamiento Vertical
  }

  static SizedBox horizontal(double width) {
    return SizedBox(width: width); //------>Espaciamiento horizontal
  }
}

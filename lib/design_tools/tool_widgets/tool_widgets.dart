import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'necesary_images.dart';

class AppWidgets {
  static String capitalizeText(String text) {
    if (text.isEmpty) {
      return '';
    }

    // Encuentra y capitaliza la primera letra en todo el texto
    final List<String> chars = text.split('');
    for (int i = 0; i < chars.length; i++) {
      if (chars[i].trim().isNotEmpty) {
        chars[i] = chars[i].toUpperCase();
        break;
      }
    }

    return chars.join();
  }

  //static String formatNumber(String textNumber) {
  //  // Filtra solo los dígitos del texto y otros caracteres permitidos
  //  final filteredText = textNumber.replaceAll(RegExp(r'[^\d\$]'), '');
//
  //  // Convierte el texto filtrado a un número entero
  //  int number = int.tryParse(filteredText.replaceAll('\$', '')) ?? 0;
//
  //  // Formatea el número con comas para separar miles y agrega de nuevo el símbolo
  //  final formatter = NumberFormat("#,###");
  //  final formattedText = formatter.format(number);
//
  //  // Si el texto original contenía el símbolo "$", agrégalo de nuevo
  //  if (textNumber.contains('\$')) {
  //    return '\$$formattedText';
  //  } else {
  //    return formattedText;
  //  }
  //}

  //----------------------------------------------------------------------------------------
  static Widget mainLogo(BuildContext context, double width, double height) {
    final Size screenSize = MediaQuery.of(context).size;
    final double logoWidth = screenSize.width * width / 100;
    final double logoHeight = screenSize.height * height / 100;

    return Container(
      height: logoHeight,
      width: logoWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(NecessaryImages.logo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  //------------------------------------------------------------------------------------

  static Widget smallText(BuildContext context, String texto, double size,
      {Color? color, TextAlign textAlign = TextAlign.justify}) {
    final double fontSize = MediaQuery.of(context).size.width * size / 100;

    final String capitalizedText = capitalizeText(texto);

    return Text(
      capitalizedText,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? AppColors.grey,
        decoration: TextDecoration.none,
        fontFamily: 'Syne',
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ),
    );
  }

  static Widget mainText(BuildContext context, String texto, double size,
      {Color? color, TextAlign textAlign = TextAlign.justify}) {
    final double fontSize = MediaQuery.of(context).size.width * size / 100;

    final String capitalizedText = capitalizeText(texto);

    return Text(
      capitalizedText,
      style: TextStyle(
        color: color ?? AppColors.black,
        decoration: TextDecoration.none,
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  static Widget elipsisText(BuildContext context, String texto, double size,
      {Color? color, int maxCharacters = 15}) {
    final double fontSize = MediaQuery.of(context).size.width * size / 100;

    String truncatedText = texto;

    if (texto.length > maxCharacters) {
      truncatedText = texto.substring(0, maxCharacters) + '...';
    }

    final String capitalizedText = capitalizeText(truncatedText);

    return Text(
      capitalizedText,
      style: TextStyle(
        color: color ?? AppColors.black,
        decoration: TextDecoration.none,
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

// static Widget mainnumberText(BuildContext context, String texto, double size,
//     {Color? color}) {
//   final double fontSize = MediaQuery.of(context).size.width * size / 100;
//
//   final String formattedText = formatNumber(texto);
//
//   return Text(
//     formattedText,
//     style: TextStyle(
//       color: color ?? AppColors.grey,
//       decoration: TextDecoration.none,
//       fontFamily: 'Syne',
//       fontWeight: FontWeight.bold,
//       fontSize: fontSize,
//     ),
//   );
// }

  //------------------------------------------------------------------------------------------

  static Widget customCard({
    required Widget child,
    Color? cardColor,
    ImageProvider? backgroundImage,
    double? containerHeight,
    double? containerWidth,
    double topLeftRadius = 0,
    double topRightRadius = 0,
    double bottomLeftRadius = 0,
    double bottomRightRadius = 0,
    double elevation = 0,
    Color? shadowColor,
    EdgeInsetsGeometry? margin,
    EdgeInsets padding = EdgeInsets.zero,
    BoxDecoration?
        customDecoration, // Nuevo parámetro para la decoración personalizada
  }) {
    BoxDecoration? decoration;

    if (backgroundImage != null || customDecoration != null) {
      decoration = customDecoration ??
          BoxDecoration(
            image: DecorationImage(
              image: backgroundImage!,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          );
    }

    return Card(
      shadowColor: shadowColor,
      elevation: elevation,
      color: cardColor,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
      ),
      child: Container(
        padding: padding,
        height: containerHeight,
        width: containerWidth,
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
          child: child,
        ),
      ),
    );
  }

  //---------------------------------------------------------------------------------
}

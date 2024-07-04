import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppButtons {
  Widget redButton({
    required BuildContext context,
    required String texto,
    required VoidCallback onPressed,
    double fontSize = 18,
    Color primaryColor = AppColors.red,
    Color textColor = AppColors.white,
    double horizontalPadding = 40,
    double verticalPadding = 10,
  }) {
    final double buttonFontSize =
        MediaQuery.of(context).size.width * fontSize / 100;

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * horizontalPadding / 100,
      vertical: MediaQuery.of(context).size.height * verticalPadding / 100,
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: padding,
      primary: primaryColor,
      textStyle: TextStyle(
        fontSize: buttonFontSize,
        // fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );

    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(
          fontSize: buttonFontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget whiteButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
    double fontSize = 18,
    Color primaryColor = AppColors.white,
    Color iconColor = AppColors.black,
    double horizontalPadding = 40,
    double verticalPadding = 10,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(40)),
    double? elevation,
  }) {
    final double buttonFontSize =
        MediaQuery.of(context).size.width * fontSize / 100;

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * horizontalPadding / 100,
      vertical: MediaQuery.of(context).size.height * verticalPadding / 100,
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      padding: padding,
      primary: primaryColor,
      textStyle: TextStyle(
        fontSize: buttonFontSize,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
    );

    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: buttonFontSize,
        color: iconColor,
      ),
    );
  }

  Widget blackButton({
    required BuildContext context,
    required String texto,
    required VoidCallback onPressed,
    double fontSize = 18,
    Color primaryColor = AppColors.black,
    Color textColor = AppColors.white,
    double horizontalPadding = 40,
    double verticalPadding = 10,
  }) {
    final double buttonFontSize =
        MediaQuery.of(context).size.width * fontSize / 100;

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * horizontalPadding / 100,
      vertical: MediaQuery.of(context).size.height * verticalPadding / 100,
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: padding,
      primary: primaryColor,
      textStyle: TextStyle(
        fontSize: buttonFontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );

    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(
          fontSize: buttonFontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

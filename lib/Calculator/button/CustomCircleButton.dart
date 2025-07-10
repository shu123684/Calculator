import 'package:flutter/material.dart';
import 'package:calculator/Theme/AppButtonColors.dart';

class CustomCircleButton extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool showtitle;
  final double? font_size;
  final IconData? icondata;
  final double? icon_size;
  final double? height;
  final double? shape;
  final int? flex;
  final VoidCallback onClick;
  final ButtonCategory category;

  const CustomCircleButton({
    super.key,
    this.title1,
    this.title2,
    this.showtitle = true,
    this.font_size,
    this.icondata,
    this.icon_size,
    this.height,
    this.shape,
    this.flex,
    required this.onClick,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final AppButtonColors? appButtonColors = Theme.of(
      context,
    ).extension<AppButtonColors>();

    Color? buttonBackgroundColor;
    Color? buttonForegroundColor;
    Color? buttonSplashColor;

    switch (category) {
      case ButtonCategory.primary:
        buttonBackgroundColor = appButtonColors?.primaryButtonBackground;
        buttonForegroundColor = appButtonColors?.primaryButtonForeground;
        buttonSplashColor = appButtonColors?.primarySplashColor;
        break;
      case ButtonCategory.secondary:
        buttonBackgroundColor = appButtonColors?.secondaryButtonBackground;
        buttonForegroundColor = appButtonColors?.secondaryButtonForeground;
        buttonSplashColor = appButtonColors?.secondarySplashColor;
        break;
      case ButtonCategory.special:
        buttonBackgroundColor = appButtonColors?.specialOperatorBackground;
        buttonForegroundColor = Colors.white;
        buttonSplashColor = appButtonColors?.specialSplashColor;
        break;
    }

    String displayTitle = (showtitle ? title1 : title2) ?? title1 ?? "";
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        foregroundColor: buttonForegroundColor,
        overlayColor: buttonSplashColor,
        minimumSize: Size(height ?? 30, height ?? 30),
        padding: EdgeInsets.all(5),
        shape: CircleBorder(),
      ),
      child: icondata == null
          ? Text(displayTitle, style: TextStyle(fontSize: font_size))
          : Icon(icondata, size: icon_size),
    );
  }
}

enum ButtonCategory { primary, secondary, special }

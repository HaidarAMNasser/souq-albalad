import 'package:flutter/material.dart';

class TextBoldApp extends StatelessWidget {
  final String text;
  final double? sizeFont;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const TextBoldApp({
    Key? key,
    required this.text,
    this.sizeFont,
    this.fontWeight,
    this.color,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: sizeFont ?? 20,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class FontWastFadi extends StatelessWidget {
  final String text;
  final double? sizeFont;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const FontWastFadi({
    Key? key,
    required this.text,
    this.sizeFont,
    this.fontWeight,
    this.color,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: sizeFont ?? 14,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        height: 43 / 14, // Line height: 43px / 14px
        letterSpacing: 0, // Letter spacing: 0%
      ),
    );
  }
}

class NasAswadRafee extends StatelessWidget {
  final String text;
  final double? sizeFont;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const NasAswadRafee({
    super.key,
    required this.text,
    this.sizeFont,
    this.fontWeight,
    this.color,
    this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: sizeFont ?? 12,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        height: 1.0, // Line height: 100%
        letterSpacing: 0, // Letter spacing: 0%
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mcp_app/values/colors.dart';

class Styles {
  static const BoxDecoration borderBottom = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFf1f1f1),
        width: .9,
      ),
    ),
  );
  static const BorderSide borderSide =  BorderSide(color: Color(0xFFE1E1E1), width: .9,);


  static const TextStyle errorStyleInlineFormEnd = TextStyle(
    color: Color(0xFFFF0000),
  );
  static const TextStyle textStyleHint = TextStyle(color: Color(0xFFD0D0D0));
  static const TextStyle textStyleFormLabel = TextStyle(fontSize: 16, color: Color(0xFF333333));
}

class FormStyles {
  static const Border borderBottom = Border(
    bottom: BorderSide(
      color: onSurfaceDividerLight,
      width: 0.9,
    ),
  );

  static BoxDecoration formContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
      color: borderBetweenSurfaceAndBackground,
      width: 0.7,
    ),
  );
}


class AppColors {
  static const Color primary = Color(0xFF009688);
  static const Color primaryDark = Color(0xFF00675B);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryLight = Colors.white70;
  static const Color onPrimaryMedium = Colors.white60;

  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xFF333333);
  static const Color onSurfaceMedium = Color(0xFF666666);
  static const Color onSurfaceLight = Color(0xFF999999);

  static const Color borderBetweenSurfaceAndBackground = Color(0xFFF1F1F1);

  static const Color background = Color(0xFFEFEFEF);
  static const Color onBackground = Color(0xFF333333);
  static const Color onBackgroundLight = Color(0xFF666666);
  static const Color onBackgroundMedium = Color(0xFF999999);

  static const Color accent = Color(0xFFE91E63);
  static const Color onAccent = Colors.white;
  static const Color onAccentLight = Colors.white70;
  static const Color onAccentMedium = Colors.white60;
}

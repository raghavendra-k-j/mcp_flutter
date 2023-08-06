// ignore_for_file: avoid_print

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/screens/home/view.dart';
import 'package:mcp_app/translation/translations.dart';
import 'package:mcp_app/values/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyDatabase());
  Get.put(FlutterTts());
  Get.put(Faker());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale('en', 'IN'),
      fallbackLocale: const Locale('kn', 'IN'),
      debugShowCheckedModeBanner: false,
      title: 'MCP App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            secondary: secondary
        ),
        useMaterial3: false,
        textTheme: GoogleFonts.sourceSans3TextTheme(),
      ),
      home: const HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
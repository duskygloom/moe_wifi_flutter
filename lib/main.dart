import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/core/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoE Wi-Fi',
      theme: CustomTheme.themeData,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

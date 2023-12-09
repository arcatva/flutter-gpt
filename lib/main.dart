import 'package:flutter/material.dart';
import 'package:flutter_gpt/controllers/setting_get.dart';
import 'package:flutter_gpt/views/pages/chat_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingGetLogic settingGetLogic =
        Get.put(SettingGetLogic(), permanent: true); // init the main controller
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light()),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/icons/chat_gpt.svg",
          width: 30,
          height: 30,
        ),
      ),
      body: ChatGetPage(),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../router/navigator_utils.dart';
import '../scroll/scroll_page.dart';

class MyHomePage extends StatefulWidget {
  static const String pageName = 'homePage';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(
                    context, const ScrollPage(), ScrollPage.pageName);
              },
              child: const Text('scroll'))
        ],
      ),
    );
  }
}

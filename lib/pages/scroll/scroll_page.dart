import 'package:flutter/material.dart';
import 'package:miao_app/pages/scroll/search_scroll.dart';

import '../../router/navigator_utils.dart';
import 'custom_header_scroll_2_page.dart';
import 'custom_header_scroll_page.dart';
import 'index_list_page.dart';
import 'nested_scroll_page.dart';

class ScrollPage extends StatefulWidget {
  static const String pageName = 'scrollPage';
  const ScrollPage({Key? key}) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scroll'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(context, const NestedScrollPage(),
                    NestedScrollPage.pageName);
              },
              child: const Text('NestedScrollPage')),
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(context, const SearchScrollPage(),
                    SearchScrollPage.pageName);
              },
              child: const Text('SearchScrollPage')),
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(
                    context, const IndexListPage(), IndexListPage.pageName);
              },
              child: const Text('IndexListPage')),
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(
                    context,
                    const CustomHeaderScrollPage(),
                    CustomHeaderScrollPage.pageName);
              },
              child: const Text('CustomHeaderScrollPage')),
          TextButton(
              onPressed: () {
                NavigatorUtils.defaultPush(
                    context,
                    const CustomHeaderScroll2Page(),
                    CustomHeaderScroll2Page.pageName);
              },
              child: const Text('CustomHeaderScroll2Page')),
        ],
      ),
    );
  }
}

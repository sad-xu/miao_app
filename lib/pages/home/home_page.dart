import 'package:flutter/material.dart';

import '../../router/navigator_utils.dart';
import '../scroll/scroll_page.dart';
import '../ui_1/design_course/home_design_course.dart';
import '../ui_1/fitness_app/fitness_app_home_screen.dart';
import '../ui_1/hotel_booking/hotel_home_screen.dart';
import '../ui_1/introduction_animation/introduction_animation_screen.dart';
import '../ui_2/drink_shop_home.dart';

class PageItem {
  PageItem({
    required this.name,
    required this.page,
    required this.pageName,
  });
  late final String name;
  late final dynamic page;
  late final String pageName;
}

final List<PageItem> pageList = [
  PageItem(
      name: 'scroll', page: const ScrollPage(), pageName: ScrollPage.pageName),
  PageItem(
      name: 'DEMO-1',
      page: const IntroductionAnimationScreen(),
      pageName: IntroductionAnimationScreen.pageName),
  PageItem(
      name: 'DEMO-2',
      page: const HotelHomeScreen(),
      pageName: HotelHomeScreen.pageName),
  PageItem(
      name: 'DEMO-3',
      page: const FitnessAppHomeScreen(),
      pageName: FitnessAppHomeScreen.pageName),
  PageItem(
      name: 'DEMO-4',
      page: const DesignCourseHomeScreen(),
      pageName: DesignCourseHomeScreen.pageName),
];

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
        body: ListView.separated(
          itemCount: pageList.length,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemBuilder: (context, index) {
            final item = pageList[index];
            return SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.accents[index % Colors.accents.length])),
                  onPressed: () {
                    NavigatorUtils.defaultPush(
                        context, item.page, item.pageName);
                  },
                  child: Text(
                    item.name,
                    style: const TextStyle(fontSize: 16),
                  )),
            );
          },
        ));
  }
}

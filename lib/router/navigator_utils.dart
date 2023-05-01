import 'package:flutter/material.dart';

class NavigatorUtils {
  ///进入首页/重载App
  // static gotoApp(BuildContext context,
  //     {int tabIndex = 0, Function? onCallback}) {
  //   return Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           settings: const RouteSettings(name: HomePage.pageName),
  //           builder: (context) {
  //             return RouteBack(
  //               HomePage(
  //                 tabIndex: tabIndex,
  //               ),
  //               PageType.app,
  //               onCallback: onCallback,
  //             );
  //           }),
  //           (route) => false);
  // }

  ///Material风格公共打开方式新页面，不关闭当前页
  ///[pageWidget] 跳转页
  ///[pageName] 跳转页名称
  static defaultPush(BuildContext context, Widget pageWidget, String pageName) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: pageName),
            builder: (context) => pageWidget));
  }

  ///Material风格公共打开方式新页面，并关闭当前页
  ///[pageWidget] 跳转页
  ///[pageName] 跳转页名称
  static defaultPushReplace(
      BuildContext context, Widget pageWidget, String pageName) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: pageName),
            builder: (context) => pageWidget));
  }

  ///回退至某页面
  // static backTo(BuildContext context, String pageName) {
  //   if (Navigator.canPop(context)) {
  //     Navigator.popUntil(context, ModalRoute.withName(pageName));
  //   } else {
  //     gotoApp(context);
  //   }
  // }
}

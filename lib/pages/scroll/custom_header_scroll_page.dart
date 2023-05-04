import 'package:flutter/material.dart';

class CustomHeaderScrollPage extends StatefulWidget {
  static const String pageName = 'customHeaderScrollPage';
  const CustomHeaderScrollPage({Key? key}) : super(key: key);

  @override
  State<CustomHeaderScrollPage> createState() => _CustomHeaderScrollPageState();
}

class _CustomHeaderScrollPageState extends State<CustomHeaderScrollPage>
    with TickerProviderStateMixin {
  static double headerHeight = 140;

  double _top = 0.0;

  @override
  void initState() {
    super.initState();
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('update-${notification.scrollDelta}');
      final double temp = (_top - notification.scrollDelta!).clamp(-100, 0.0);
      if (temp != _top) {
        setState(() {
          _top = temp;
        });
      }
    }
    // else if (notification is ScrollStartNotification) {
    //   print('start-${notification.dragDetails?.globalPosition}');
    // }
    print(_top);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: NotificationListener(
          onNotification: _onNotification,
          child: Stack(
            children: [
              Positioned(
                top: _top,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Column(
                  children: [
                    Container(
                      height: headerHeight,
                      color: Colors.white12,
                      child: CustomHeader(percent: _top * -1),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                            alignment: Alignment.center,
                            child: Text(
                              '$index',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          );
                        },
                        itemCount: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

class CustomHeader extends StatelessWidget {
  final double percent;
  const CustomHeader({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Opacity(
        opacity: percent / 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [Text('$percent'), Text('AAAA')],
            )
          ],
        ),
      ),
      Opacity(
          opacity: (100 - percent) / 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$percent'),
              Text('AAAA'),
              Text('BBBB'),
              Text('CCCCC')
            ],
          )),
    ]);
  }
}

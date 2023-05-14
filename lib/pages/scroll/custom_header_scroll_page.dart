import 'package:flutter/material.dart';

class CustomHeaderScrollPage extends StatefulWidget {
  static const String pageName = 'customHeaderScrollPage';
  const CustomHeaderScrollPage({Key? key}) : super(key: key);

  @override
  State<CustomHeaderScrollPage> createState() => _CustomHeaderScrollPageState();
}

class _CustomHeaderScrollPageState extends State<CustomHeaderScrollPage> {
  ///滚动高度 [0, -xx]
  double _top = 0.0;

  ///头部展开
  bool _isToggle = false;

  ///展开key
  final _headerMaxKey = GlobalKey();

  ///收起key
  final _headerMinKey = GlobalKey();

  ///头部高度 大
  double _headerMaxHeight = 20;

  ///头部高度 小
  double _headerMinHeight = 10;

  @override
  void initState() {
    super.initState();
    _calcHeaderMaxHeight();
    _calcHeaderMinHeight();
  }

  ///滚动监听
  bool _onNotification(ScrollNotification notification) {
    // print(notification.depth);
    if (notification is ScrollUpdateNotification) {
      // print('update-${notification.scrollDelta}');
      final double temp = (_top - notification.scrollDelta!)
          .clamp(_headerMinHeight - _headerMaxHeight, 0.0);
      if (temp != _top) {
        setState(() {
          _top = temp;
        });
      }
    }
    // else if (notification is ScrollStartNotification) {
    //   print('start-${notification.dragDetails?.globalPosition}');
    // }
    // print(_top);
    return true;
  }

  ///计算头部max高度
  void _calcHeaderMaxHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerMaxHeight = _headerMaxKey.currentContext!.size!.height;
      });
    });
  }

  ///计算头部min高度
  void _calcHeaderMinHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerMinHeight = _headerMinKey.currentContext!.size!.height;
      });
    });
  }

  Widget _headerWidget(double percent) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      ///min
      Opacity(
          opacity: percent,
          child: Container(
              key: _headerMinKey,
              height: 100,
              width: double.infinity,
              color: Colors.yellow,
              child: Text('$percent'))),

      ///max
      Opacity(
          opacity: 1 - percent,
          child: SizedBox(
            height: _headerMaxHeight + _top,
            child: ListView(
              children: [
                Container(
                  key: _headerMaxKey,
                  color: Colors.deepOrangeAccent,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text('${percent}'),
                      Text('AAAA'),
                      Text('BBBB'),
                      Text('CCCCC'),
                      TextButton(
                          onPressed: () {
                            _calcHeaderMaxHeight();
                            setState(() {
                              _isToggle = !_isToggle;
                            });
                          },
                          child: Text('TOGGLE')),
                      SizedBox(height: _isToggle ? 180 : 80)
                    ],
                  ),
                )
              ],
            ),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('scroll'),
        ),
        body: Column(
          children: [
            _headerWidget(_top / (_headerMinHeight - _headerMaxHeight)),
            Expanded(
                child: NotificationListener(
                    onNotification: _onNotification,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          // color: Colors.primaries[index % Colors.primaries.length],
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child: Text(
                            '$index',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        );
                      },
                      itemCount: 20,
                    )))
          ],
        ));
  }
}

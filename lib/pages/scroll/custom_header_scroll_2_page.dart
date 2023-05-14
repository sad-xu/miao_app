import 'package:flutter/material.dart';

class CustomHeaderScroll2Page extends StatefulWidget {
  static const String pageName = 'customHeaderScroll2Page';
  const CustomHeaderScroll2Page({Key? key}) : super(key: key);

  @override
  State<CustomHeaderScroll2Page> createState() =>
      _CustomHeaderScroll2PageState();
}

class _CustomHeaderScroll2PageState extends State<CustomHeaderScroll2Page> {
  final _scrollController = ScrollController();

  ///滚动高度 [0, xx]
  double _top = 0.0;

  ///头部展开
  bool _isToggle = false;

  ///展开key
  final _headerMaxKey = GlobalKey();

  ///收起key
  final _headerMinKey = GlobalKey();

  ///头部高度 大
  double _headerMaxHeight = 50;

  ///头部高度 小
  double _headerMinHeight = 40;

  @override
  void initState() {
    super.initState();
    // _calcHeaderMinHeight();
    // _calcHeaderMaxHeight();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerMinHeight = _headerMinKey.currentContext!.size!.height;
        _headerMaxHeight = _headerMaxKey.currentContext!.size!.height;
      });
    });
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset < _headerMaxHeight - _headerMinHeight) {
        setState(() {
          _top = offset;
        });
        // print('$_top-$_headerMaxHeight-$_headerMinHeight');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  ///计算头部max高度
  void _calcHeaderMaxHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerMaxHeight = _headerMaxKey.currentContext!.size!.height;
        print(_headerMaxHeight);
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
          child: ListView(
            children: [
              Container(
                  key: _headerMinKey,
                  height: 50,
                  width: double.infinity,
                  color: Colors.yellow,
                  child: Text('$percent'))
            ],
          )),

      ///max
      Opacity(
          opacity: 1 - percent,
          child: SizedBox(
            height: _headerMaxHeight - _top,
            child: ListView(
              children: [
                Container(
                  key: _headerMaxKey,
                  color: Colors.deepOrangeAccent,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text('${percent}'),
                      TextButton(
                          onPressed: () {
                            print(_isToggle);
                            _calcHeaderMaxHeight();
                            setState(() {
                              _isToggle = !_isToggle;
                            });
                            // _scrollController.animateTo(0.0,
                            //     duration: const Duration(milliseconds: 200),
                            //     curve: Curves.linear);
                          },
                          child: Text('TOGGLE')),
                      Container(
                        height: _isToggle ? 180 : 80,
                        child: Text('$_isToggle'),
                      )
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
        appBar: AppBar(title: const Text('scroll')),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverAppBar(
            //   pinned: true,
            //   automaticallyImplyLeading: false,
            //   expandedHeight: 250.0,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Container(
            //       height: 100,
            //       width: double.infinity,
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(child: SizedBox(height: 200)),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                  maxHeight: _headerMaxHeight,
                  minHeight: _headerMinHeight,
                  child: _headerWidget(
                      _top / (_headerMaxHeight - _headerMinHeight))),
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text(
                        '${_headerMinHeight}-${_headerMaxHeight} -list item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ));
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    required this.minHeight,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) {
    return true;
    // return oldDelegate.maxExtent != maxExtent ||
    //     oldDelegate.minExtent != minExtent;
  }
}

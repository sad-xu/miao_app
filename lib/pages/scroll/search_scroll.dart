import 'package:flutter/material.dart';

class SearchScrollPage extends StatefulWidget {
  static const String pageName = 'searchScrollPage';
  const SearchScrollPage({Key? key}) : super(key: key);

  @override
  State<SearchScrollPage> createState() => _SearchScrollPageState();
}

class _SearchScrollPageState extends State<SearchScrollPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // tabController.addListener(tabControlerListener);
  }

  @override
  void dispose() {
    // tabController.removeListener(tabControlerListener);
    super.dispose();
  }

//   int index = 0;
//   void tabControlerListener() {
// //    if (index != tabController.index)
// //    //if(tabController.indexIsChanging)
// //    //if(tabController.previousIndex!=tabController.index)
// //    {
// //      setState(() {});
// //    }
// //    index = tabController.index;
//   }

  double _top = 0.0;
  bool _onNotification(ScrollNotification notification) {
    if (notification.depth == 1) {
      if (notification is ScrollUpdateNotification) {
        final double temp =
            (_top - notification.scrollDelta!).clamp(-50.0, 0.0);
        if (temp != _top) {
          setState(() {
            _top = temp;
          });
        }
      }
    }
    return false;
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
                      alignment: Alignment.center,
                      height: 50.0,
                      color: Colors.red,
                      child: const Text('输入框'),
                    ),
                    TabBar(
                      controller: tabController,
                      labelColor: Colors.blue,
                      indicatorColor: Colors.blue,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 2.0,
                      isScrollable: false,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'Tab0'),
                        Tab(text: 'Tab1'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ListView.builder(
                            key: const PageStorageKey('Tab1'),
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext c, int i) {
                              return Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                child: Text('${const Key('Tab1')}: ListView$i'),
                              );
                            },
                            itemCount: 50,
                          ),
                          ListView.builder(
                            key: const PageStorageKey('Tab2'),
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext c, int i) {
                              return Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                child: Text('${const Key('Tab1')}: ListView$i'),
                              );
                            },
                            itemCount: 50,
                          ),
                        ],
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

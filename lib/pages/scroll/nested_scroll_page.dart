import 'package:flutter/material.dart';

class NestedScrollPage extends StatefulWidget {
  static const String pageName = 'nestedScrollPage';
  const NestedScrollPage({Key? key}) : super(key: key);

  @override
  State<NestedScrollPage> createState() => _NestedScrollPageState();
}

class _NestedScrollPageState extends State<NestedScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 230.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('NAME'),
                background: Image.network(
                  'https://cn.bing.com/th?id=OHR.JTNPMilkyWay_ZH-CN9128830420_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&qlt=50',
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              color: Colors.primaries[index % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}

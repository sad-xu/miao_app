import 'package:flutter/material.dart';

class Friends {
  final String name;
  final String letter;
  Friends({required this.name, required this.letter});
}

List<Friends> datas = [
  Friends(name: 'Lina', letter: 'L'),
  Friends(name: '菲儿', letter: 'F'),
  Friends(name: '安莉', letter: 'A'),
  Friends(name: '阿贵', letter: 'A'),
  Friends(name: '贝拉', letter: 'B'),
  Friends(name: 'Lina', letter: 'L'),
  Friends(name: 'Nancy', letter: 'N'),
  Friends(name: '扣扣', letter: 'K'),
  Friends(name: 'Jack', letter: 'J'),
  Friends(name: 'Emma', letter: 'E'),
  Friends(name: 'Abby', letter: 'A'),
  Friends(name: 'Betty', letter: 'B'),
  Friends(name: 'Tony', letter: 'T'),
  Friends(name: 'Jerry', letter: 'J'),
  Friends(name: 'Colin', letter: 'C'),
  Friends(name: 'Haha', letter: 'H'),
  Friends(name: 'Ketty', letter: 'K'),
  Friends(name: 'Lina', letter: 'L'),
  Friends(name: 'Lina', letter: 'L'),
];

///
class IndexListPage extends StatefulWidget {
  static const String pageName = 'IndexListPage';
  const IndexListPage({Key? key}) : super(key: key);

  @override
  State<IndexListPage> createState() => _IndexListPageState();
}

class _IndexListPageState extends State<IndexListPage> {
  final ScrollController _scrollController = ScrollController();

  //字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {};
  //名称数据
  final List<Friends> _listDatas = [];

  @override
  void initState() {
    super.initState();
    _listDatas
      ..addAll(datas)
      ..addAll(datas);
    _listDatas.sort((Friends a, Friends b) {
      return a.letter.compareTo(b.letter);
    });

    var groupOffset = 0.0;
    //经过循环计算，将每一个头的位置算出来，放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1 || _listDatas[i].letter != _listDatas[i - 1].letter) {
        _groupOffsetMap.addAll({_listDatas[i].letter: groupOffset});
        //保存完了再加——groupOffset偏移
        groupOffset += 86;
      } else {
        groupOffset += 50;
      }
    }
    // 监听当前页面滑动的偏移量，判断和_groupOffsetMap存储的每组组头记录的偏移量的位置，并把位置传入到指示器页面，刷新当前指示器指示的位置
    _scrollController.addListener(() {
      for (int i = 0; i < _groupOffsetMap.values.length - 1; i++) {
        double start = _groupOffsetMap.values.elementAt(i);
        double end = _groupOffsetMap.values.elementAt(i + 1);
        if (start < _scrollController.offset &&
            end > _scrollController.offset) {
          indexBarKey.currentState?.setIndexSelect(i);
          break;
        }
        if (start == _scrollController.offset) {
          indexBarKey.currentState?.setIndexSelect(i);
          break;
        }
        if (end == _scrollController.offset) {
          indexBarKey.currentState?.setIndexSelect(i + 1);
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> indexWordList = [];
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1 || _listDatas[i].letter != _listDatas[i - 1].letter) {
        indexWordList.add(_listDatas[i].letter);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('index list'),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: _listDatas.length,
                  itemBuilder: (context, index) {
                    bool hideLetter = (index > 0 &&
                        _listDatas[index].letter ==
                            _listDatas[index - 1].letter);
                    return GroupItemWidget(
                      name: _listDatas[index].name,
                      groupTitle: hideLetter ? null : _listDatas[index].letter,
                    );
                  },
                ),
                IndexBar(
                  key: indexBarKey,
                  indexWordList: indexWordList,
                  indexBarCallBack: (String str) {
                    final num = _groupOffsetMap[str];
                    if (num != null) {
                      _scrollController.animateTo(num,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeIn);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

GlobalKey<_IndexBarState> indexBarKey = GlobalKey();

///指示器
class IndexBar extends StatefulWidget {
  ///索引字母列表
  final List<String> indexWordList;
  ///
  final void Function(String str) indexBarCallBack;
  const IndexBar({Key? key, required this.indexBarCallBack, required this.indexWordList}) : super(key: key);

  @override
  State<IndexBar> createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  double _indicatorY = 0.0; //悬浮窗位置
  String _indicatorText = 'A'; //显示的字母
  bool _indicatorHidden = true; //是否隐藏悬浮窗
  int _indexSelect = 0;

  ///外部调用
  void setIndexSelect(int index) {
    setState(() {
      _indexSelect = index;
    });
  }

  int _getIndex(BuildContext context, Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    double y = box.globalToLocal(globalPosition).dy;
    int index = (y ~/ 24).clamp(0, widget.indexWordList.length - 1);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0.0,
      height: 24.0 * widget.indexWordList.length,
      top: MediaQuery.of(context).size.height / 4 -
          // DataBase.STATUS_BAR_HEIGHT -
          40,
      width: 140,
      child: Row(
        children: [
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: _indicatorHidden
                ? null
                : Stack(
                    alignment: const Alignment(-0.2, 0),
                    children: [
                      Text(
                        _indicatorText,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.blue),
                      ),
                    ],
                  ),
          ),
          GestureDetector(
            child: Container(
              width: 40,
              alignment: Alignment.centerRight,
              child: Column(
                children: widget.indexWordList.asMap().entries.map((d) {
                  final index = d.key;
                  final letter = d.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _indexSelect = index;
                      });
                    },
                    child: Container(
                      height: 24,
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(
                        letter,
                        style: TextStyle(
                            fontSize: 14,
                            color: _indexSelect == index
                                ? const Color(0xFF476FFE)
                                : const Color(0xFF666666)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = _getIndex(context, details.globalPosition);
              _indexSelect = index;
              setState(() {
                _indicatorText = widget.indexWordList[index];
                _indicatorY = 2.2 / widget.indexWordList.length * index - 1.1;
                _indicatorHidden = false;
              });
              widget.indexBarCallBack(widget.indexWordList[index]);
            },
            onVerticalDragDown: (DragDownDetails details) {
              int index = _getIndex(context, details.globalPosition);
              _indicatorText = widget.indexWordList[index];
              _indicatorY = 2.2 / widget.indexWordList.length * index - 1.1;
              _indicatorHidden = true;
              widget.indexBarCallBack(widget.indexWordList[index]);
              _indexSelect = index;
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _indicatorHidden = true;
              });
            },
          )
        ],
      ),
    );
  }
}

///cell
class GroupItemWidget extends StatelessWidget {
  final String name;
  final String? groupTitle;

  const GroupItemWidget(
      {super.key, required this.name, required this.groupTitle});
  @override
  Widget build(BuildContext context) {
    final nameWidget = Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      height: 50,
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        name,
        style: const TextStyle(fontSize: 15, color: Color(0xFF646464)),
      ),
    );

    return GestureDetector(
        onTap: () {},
        child: groupTitle != null
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    height: 36,
                    child: Text(
                      groupTitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  nameWidget
                ],
              )
            : nameWidget);
  }
}

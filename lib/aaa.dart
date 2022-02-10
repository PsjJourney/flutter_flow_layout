import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<Color> colors = <Color>[];
  int crossAxisCount = 2;
  double crossAxisSpacing = 5.0;
  double mainAxisSpacing = 5.0;

  Color getRandomColor(int index) {
    if (index >= colors.length) {
      colors.add(Color.fromARGB(255, Random.secure().nextInt(255),
          Random.secure().nextInt(255), Random.secure().nextInt(255)));
    }

    return colors[index];
  }

  Widget listItem(int position) {
    Color color;
    if (position % 2 == 0) {
      color = Colors.red;
    } else if (position % 2 == 1) {
      color = Colors.blue;
    } else {
      color = Colors.yellow;
    }
    Widget widget = Container(
      color: color,
      width: double.infinity,
      height: 200,
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ahahdiahsdiha"),
        ),
        body: EasyRefresh.builder(builder: (context, physics, header, footer) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((content, index) {
                  return listItem(index);
                }, childCount: 20),
              ),
              SliverWaterfallFlow(
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  collectGarbage: (List<int> garbages) {
                    print('collect garbage : $garbages');
                  },
                  viewportBuilder: (int firstIndex, int lastIndex) {
                    print('viewport : [$firstIndex,$lastIndex]');
                  },
                ),
                delegate:
                    SliverChildBuilderDelegate((BuildContext c, int index) {
                  final Color color = getRandomColor(index);
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: getRandomColor(index)),
                    alignment: Alignment.center,
                    child: Text(
                      '$index',
                      style: TextStyle(
                          color: color.computeLuminance() < 0.5
                              ? Colors.white
                              : Colors.black),
                    ),
                    //height: index == 5 ? 1500.0 : 100.0,
                    height: ((index % 3) + 1) * 100.0,
                  );
                }),
              )
            ],
          );
        }));
  }
}

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:diaryschool/pages/timetable_page/widgets/day_week_carousel_widget.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
//  static String kKey = "TimetablePage";

  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  DateTime dt = DateTime.now();
  Animation<double> _animation;
//  TabController _controller;
//  PageController _pageController;
  ScrollController _scrollController;
  double previousIconSize = 0.0;
  double nextIconSize = 0.0;
  final List<String> _carouselItems = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье"
  ];
  @override
  void initState() {
//    _carouselItemsWidgets = _carouselItems
//        .map(
//          (e) => Container(
//            padding: const EdgeInsets.all(8.0),
//            child: Text(
//              e,
//              style: const TextStyle(fontSize: 25.0),
//            ),
//          ),
//        )
//        .toList();
//    _carouselItemsWidgets.insert(
//      0,
//      AnimatedContainer(
//        color: Colors.black,
//        height: previousIconSize,
//        width: previousIconSize,
//        duration: const Duration(milliseconds: 200),
//        child: Icon(
//          Icons.arrow_forward_ios,
//          color: Colors.black,
//          size: nextIconSize,
//        ),
//      ),
//    );
//    _carouselItemsWidgets.add(
//      AnimatedContainer(
//        color: Colors.black,
//        height: previousIconSize,
//        width: previousIconSize,
//        duration: const Duration(milliseconds: 200),
//        child: Icon(
//          Icons.arrow_forward_ios,
//          color: Colors.black,
//          size: nextIconSize,
//        ),
//      ),
//    );
    _animation = AnimationController(
        value: previousIconSize, vsync: this, upperBound: 100.0);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset < 0 && _scrollController.offset > -30) {
        previousIconSize = _scrollController.offset.abs();
        setState(() {});
      }
      if (_scrollController.offset < -50) {
//        print(previousIconSize);
//        print(_scrollController.offset.abs());
        setState(() {});
      }
//      print(_scrollController.position);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
//    _controller.dispose();
//    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedBuilder(
                    animation: _animation,
                    builder: (BuildContext context, Widget w) {
                      return Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(100.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: previousIconSize,
                        ),
                      );
                    }),
//                AnimatedIcon(
//                  icon: AnimatedIcons.arrow_menu,
//                  progress: _animation,
//                  size: previousIconSize,
//                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _carouselItems.length,
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        _carouselItems[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8.0,
                    ),
//              shrinkWrap: true,
//              children: _carouselItemsWidgets,
//              children: _carouselItems
//                  .map(
//                    (e) => Container(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text(
//                        e,
//                        style: const TextStyle(fontSize: 25.0),
//                      ),
//                    ),
//                  )
//                  .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

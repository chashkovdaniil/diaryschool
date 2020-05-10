//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/material.dart';
//
//
//class DayWeekCarouselWidget extends StatefulWidget {
//  DayWeekCarouselWidget({Key key}) : super(key: key);
//  @override
//  _DayWeekCarouselWidgetState createState() => _DayWeekCarouselWidgetState();
//}
//
//class _DayWeekCarouselWidgetState extends State<DayWeekCarouselWidget> {
//  final List<String> _carouselItems = [
//    "Понедельник",
//    "Вторник",
//    "Среда",
//    "Четверг",
//    "Пятница",
//    "Суббота",
//    "Воскресенье"
//  ];
//  int _activePage = 0;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        children: <Widget>[
//          CarouselSlider(
//            options: CarouselOptions(
//              height: 70.0,
//              viewportFraction: 0.5,
//              onPageChanged: (page, reason) {
//                _activePage = page;
//                setState(() {});
//              },
//            ),
//            items: _carouselItems.map(
//              (e) {
//                return Builder(
//                  builder: (BuildContext context) {
//                    return Container(
//                      child: Center(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              e,
//                              textAlign: TextAlign.left,
//                              style: TextStyle(
//                                  fontSize: 25.0,
//                                  fontWeight:
//                                      _carouselItems.indexOf(e) == _activePage
//                                          ? FontWeight.w900
//                                          : FontWeight.bold),
//                            ),
//                            SizedBox(),
//                          ],
//                        ),
//                      ),
//                    );
//                  },
//                );
//              },
//            ).toList(),
//          )
//        ],
//      ),
//    );
//  }
//}

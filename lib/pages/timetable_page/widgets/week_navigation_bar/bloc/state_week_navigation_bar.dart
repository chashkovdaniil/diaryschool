//import 'package:equatable/equatable.dart';
//import 'package:flutter/cupertino.dart';
//
//abstract class WeekNavigationBarState extends Equatable {
//  final DateTime dateTime;
//  WeekNavigationBarState({this.dateTime});
//
//  @override
//  List<Object> get props => [dateTime];
//}
//
//class UpdateIconsSizeState extends WeekNavigationBarState {
//  final double nextIconSize;
//  final double prevIconSize;
//  UpdateIconsSizeState(
//      {@required this.nextIconSize, @required this.prevIconSize});
//
//  @override
//  List<Object> get props => [nextIconSize, prevIconSize];
//}
//
//
//
//class ScrollToWeekState extends WeekNavigationBarState {
//  ScrollToWeekState({DateTime dateTime}) : super(dateTime: dateTime);
////  final DateTime dateTime;
////  ScrollToWeekState({this.dateTime});
//
//  @override
//  List<Object> get props => [dateTime];
//}
////class WeekNavigationBarStateWeekDay extends WeekNavigationBarState {
////  final DateTime dateTime;
////  WeekNavigationBarStateWeekDay({this.dateTime});
////  @override
////  List<Object> get props => [dateTime];
////}
//
//class WeekNavigationBarInitial extends WeekNavigationBarState {
//  final double prevIconSize = 0.0;
//  final double nextIconSize = 0.0;
//  final DateTime dateTime =
//      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));
//  @override
//  List<Object> get props => [prevIconSize, nextIconSize, dateTime];
//}

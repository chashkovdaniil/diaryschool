import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'state_week_navigation_bar.dart';

abstract class WeekNavigationBarEvent extends Equatable {
  const WeekNavigationBarEvent();

  @override
  List<Object> get props => [];
}

//class UpdatePrevIconSizeEvent extends WeekNavigationBarEvent {
//  final double prevIconSize;
//  UpdatePrevIconSizeEvent({@required this.prevIconSize});
//
//  @override
//  List<Object> get props => [prevIconSize];
//}

//class UpdateNextIconSizeEvent extends WeekNavigationBarEvent {
//  final double nextIconSize;
//  UpdateNextIconSizeEvent({@required this.nextIconSize});
//
//  @override
//  List<Object> get props => [nextIconSize];
//}
enum PreviousOrNext {previous, next}

class ScrollToWeekEvent extends WeekNavigationBarEvent {
  final PreviousOrNext previousOrNext;
  ScrollToWeekEvent({this.previousOrNext});

  @override
  List<Object> get props => [previousOrNext];
}

class UpdateIconsSizeEvent extends WeekNavigationBarEvent {
  final double nextIconSize;
  final double prevIconSize;
  UpdateIconsSizeEvent(
      {@required this.nextIconSize, @required this.prevIconSize});

  @override
  List<Object> get props => [nextIconSize, prevIconSize];
}

//class ScrollToNextWeekEvent extends WeekNavigationBarEvent {
////  ScrollToNextWeekEvent({DateTime dateTime}) : super(dateTime: dateTime);
////  ScrollToNextWeekEvent({DateTime dateTime}) : super(dateTime: dateTime);
//  @override
//  List<Object> get props => super.props;
//}

//class ScrollToPreviousWeekEvent extends WeekNavigationBarEvent {
//  ScrollToPreviousWeekEvent({DateTime dateTime}) : super(dateTime: dateTime);
//  DateTime dateTime;
//  ScrollToPreviousWeekEvent({DateTime dateTime}) : super(dateTime: dateTime);
//  @override
//  List<Object> get props => super.props;
//}

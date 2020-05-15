//import 'package:bloc/bloc.dart';
//import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/bloc/state_week_navigation_bar.dart';
//import 'event_week_navigation_bar.dart';
//
//class WeekNavigationBarBloc
//    extends Bloc<WeekNavigationBarEvent, WeekNavigationBarState> {
//  @override
//  WeekNavigationBarState get initialState => WeekNavigationBarInitial();
//
//  @override
//  Stream<WeekNavigationBarState> mapEventToState(
//      WeekNavigationBarEvent event) async* {
//    if (event is UpdateIconsSizeEvent) {
//      yield UpdateIconsSizeState(
//          prevIconSize: event.prevIconSize, nextIconSize: event.nextIconSize);
//    } else if (event is ScrollToWeekEvent) {
//      yield ScrollToWeekState(
//          dateTime: state.dateTime.add(Duration(
//              days: event.previousOrNext == PreviousOrNext.next ? 7 : -7)));
//    }
////    else if (event is ScrollToPreviousWeekEvent) {
////      yield state.add(const Duration(days: -7));
////    }
//  }
//}

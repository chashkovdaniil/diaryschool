import 'dart:async' show Future;

import 'package:flutter/material.dart' show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:flutter/foundation.dart' show SynchronousFuture;

class DLocalizations {
  DLocalizations(this.locale);

  final Locale locale;

  static DLocalizations of(BuildContext context) {
    return Localizations.of<DLocalizations>(context, DLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // ---- Пункты настроек
      'timetable': 'Timetable',
      'settings': 'Settings',
      'subjects': 'Lessons',
      'grades': 'Grades',
      'aboutApp': 'About app',
      'feedback': 'Give feedback',
      'donate': 'Donate',
      'importexportdata': 'Import/Export Data',
      // ---- Универсальное
      'cancel': 'Cancel',
      'ok': 'Ok',
      'add': 'Add',
      'edit': 'Edit',
      'save': 'Save',
      'fillinthefield': 'Fill in the field',
      'thisisalreadythere': 'This is already there!',
      'added': 'Added',
      'changed': 'Changed',
      'Done': 'Done',
      // ---- Дни недели
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'mon': 'Mon',
      'tue': 'Tue',
      'wed': 'Wed',
      'thu': 'Thu',
      'fri': 'Fri',
      'sat': 'Sat',
      'sun': 'Sun',
      'today': 'Today',
      // ---- Месяца
      'January': 'January',
      'February': 'February',
      'March': 'March',
      'April': 'April',
      'May': 'May',
      'June': 'June',
      'July': 'July',
      'August': 'August',
      'September': 'September',
      'November': 'November',
      'October': 'October',
      'December': 'December',
      'jan': 'jan',
      'feb': 'feb',
      'mar': 'mar',
      'apr': 'apr',
      'may': 'may',
      'jun': 'june',
      'jul': 'jule',
      'aug': 'aug',
      'sep': 'sep',
      'oct': 'oct',
      'nov': 'nov',
      'dec': 'dec',
      // ---- Уведомления 
      'notification': 'Notification',
      'notificationenabled': 'Notification enabled',
      'notificationdisabled': 'Notification disabled',
      'timenotification': 'Reminder time',
      'notificationtooltip': 'This notice will remind you to pack',
      'titleNotification': 'Time to pack',
      'textNotification': 'Take a look at the timetable!',
      // Контакты
      'contacts': 'Contacts',
      'vk': 'Open profile in VK',
      'privacypolicy': 'Privacy policy',
      'email': 'Email',
      // ---- Уроки
      'nolessons': 'No lessons',
      'addlesson': 'Add lesson',
      'fillintheschedule': 'Fill in the timetable',
      'notdone': 'Not done',
      'youhavedoneeverything': 'You have done everything',
      'nogrades': 'No grades',
      'grade': 'Grade',
      'whatdidyougetaskedtoday': 'What did you get asked today?',
      'isdone': 'Done?',
      'addlessonfirst': 'Add lesson first',
      'chooselesson': 'Choose lesson',
      'titlelesson': 'Title',
      'teachersfullname': 'Teacher\'s full name',
      'HomeworkNotDone': 'Homework not done',
      'HomeworkDone': 'Homework done',
      'homeworktooltip': 'Click on subject title to write homework',
      'edithomeworktooltip': 'Click below to indicate that the task is completed or not completed, and then click Finish',
      'notdonetooltip': 'Unfulfilled homework is shown here to indicate that the task has been completed, double-click on it (the line on the side should turn green). The same can be done on the main screen.',
      'subjectstooltip': 'To edit subject, click on it.',
      'startlesson': 'Start lesson',
      'endlesson': 'End lesson',
      'newhomeworks': 'New homework',
      'clicktoselectdate': 'Click to select date',
      'next': 'Next',
      'import': 'Import',
      'export': 'Export'
    },
    'ru': {
      // ---- Пункты настроек
      'timetable': 'Расписание',
      'settings': 'Настройки',
      'subjects': 'Предметы',
      'grades': 'Оценки',
      'aboutApp': 'О приложении',
      'feedback': 'Оставить отзыв',
      'donate': 'Поддержать проект',
      'importexportdata': 'Импорт/Экспорт данных',
      // ---- Универсальное
      'cancel': 'Отмена',
      'ok': 'Ок',
      'add': 'Добавить',
      'fillinthefield': 'Заполните поле',
      'thisisalreadythere': 'Такой уже есть!',
      'added': 'Добавлено',
      'changed': 'Изменено!',
      'Done': 'Готово',
      'edit': 'Редактировать',
      'save': 'Сохранить',
      // ---- Дни недели
      'monday': 'Понедельник',
      'tuesday': 'Вторник',
      'wednesday': 'Среда',
      'thursday': 'Четверг',
      'friday': 'Пятница',
      'saturday': 'Суббота',
      'sunday': 'Воскресенье',
      'mon': 'Пн',
      'tue': 'Вт',
      'wed': 'Ср',
      'thu': 'Чт',
      'fri': 'Пт',
      'sat': 'Сб',
      'sun': 'Вс',
      'today': 'Сегодня',
      // ---- Месяца
      'January': 'Январь',
      'February': 'Февраль',
      'March': 'Март',
      'April': 'Апрель',
      'May': 'Май',
      'June': 'Июнь',
      'July': 'Июль',
      'August': 'Август',
      'September': 'Сентябрь',
      'October': 'Октябрь',
      'November': 'Ноябрь',
      'December': 'Декабрь',
      'jan': 'янв',
      'feb': 'фев',
      'mar': 'мар',
      'apr': 'апр',
      'may': 'май',
      'jun': 'июнь',
      'jul': 'июль',
      'aug': 'авг',
      'sep': 'сен',
      'oct': 'окт',
      'nov': 'ноя',
      'dec': 'дек',
      // ---- Уведомления 
      'notification': 'Уведомление',
      'notificationenabled': 'Уведомление включено',
      'notificationdisabled': 'Уведомление выключено',
      'timenotification': 'Время напоминания',
      'notificationtooltip': 'Данное уведомление будет напоминать о том, что необходимо собрать рюкзак',
      'titleNotification': 'Время собирать рюкзак',
      'textNotification': 'Загляните в расписание!',
      // ---- Контакты
      'contacts': 'Контакты',
      'vk': 'Открыть профиль в ВКонтакте',
      'privacypolicy': 'Политика конфиденциальности',
      'email': 'Эл. почта',
      // ---- Уроки
      'nolessons': 'Нет уроков',
      'addlesson': 'Добавить урок',
      'fillintheschedule': 'Заполните расписание',
      'notdone': 'Не сделано',
      'youhavedoneeverything': 'У вас всё сделано',
      'nogrades': 'Нет оценок',
      'grade': 'Оценка',
      'whatdidyougetaskedtoday': 'Что вам задали сегодня?',
      'isdone': 'Сделано?',
      'addlessonfirst': 'Добавьте предмет',
      'chooselesson': 'Выберите предмет',
      'titlelesson': 'Название',
      'teachersfullname': 'ФИО учителя',
      'HomeworkNotDone': 'Задание не выполнено',
      'HomeworkDone': 'Задание выполнено',
      'homeworktooltip': 'Нажмите на название предмета, чтобы записать домашнее задание',
      'edithomeworktooltip': 'Нажмите ниже, чтобы отметить, что задание выполнено или не выполнено, а затем нажмите "Готово"',
      'notdonetooltip': 'Здесь показываются невыполненное домашнее задание, чтобы отметить, что задание выполнено нажмите дважды на него (линия сбоку должна стать зелёной). То же самое можно сделать и на главном экране.',
      'subjectstooltip': 'Чтобы редактировать предмет, нажмите на него',
      'startlesson': 'Начало урока',
      'endlesson': 'Конец урока',
      'newhomeworks': 'Новое задание',
      'clicktoselectdate': 'Нажмите, чтобы выбрать дату',
      'next': 'Далее',
      'import': 'Импорт',
      'export': 'Экспорт'
    },
  };
  String get importexportdata {
    return _localizedValues[locale.languageCode]['importexportdata'];
  }
  String get export {
    return _localizedValues[locale.languageCode]['export'];
  }
  String get import {
    return _localizedValues[locale.languageCode]['import'];
  }
  String get next {
    return _localizedValues[locale.languageCode]['next'];
  }
  String get clicktoselectdate {
    return _localizedValues[locale.languageCode]['clicktoselectdate'];
  }
  String get newhomeworks {
    return _localizedValues[locale.languageCode]['newhomeworks'];
  }
  String get timetable {
    return _localizedValues[locale.languageCode]['timetable'];
  }
  String get settings {
    return _localizedValues[locale.languageCode]['settings'];
  }
  String get subjects {
    return _localizedValues[locale.languageCode]['subjects'];
  }
  String get aboutApp {
    return _localizedValues[locale.languageCode]['aboutApp'];
  }
  String get grades {
    return _localizedValues[locale.languageCode]['grades'];
  }
  String get monday {
    return _localizedValues[locale.languageCode]['monday'];
  }
  String get tuesday {
    return _localizedValues[locale.languageCode]['tuesday'];
  }
  String get wednesday {
    return _localizedValues[locale.languageCode]['wednesday'];
  }
  String get thursday {
    return _localizedValues[locale.languageCode]['thursday'];
  }
  String get friday {
    return _localizedValues[locale.languageCode]['friday'];
  }
  String get saturday {
    return _localizedValues[locale.languageCode]['saturday'];
  }
  String get sunday {
    return _localizedValues[locale.languageCode]['sunday'];
  }
  String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }
  String get ok {
    return _localizedValues[locale.languageCode]['ok'];
  }
  // ---------------------
  // Уведомление
  // ---------------------
  String get notification {
    return _localizedValues[locale.languageCode]['notification'];
  }
  String get notificationenabled {
    return _localizedValues[locale.languageCode]['notificationenabled'];
  }
  String get notificationdisabled {
    return _localizedValues[locale.languageCode]['notificationdisabled'];
  }
  String get timenotification {
    return _localizedValues[locale.languageCode]['timenotification'];
  }
  String get notificationtooltip {
    return _localizedValues[locale.languageCode]['notificationtooltip'];
  }
  // ---------------------
  // Контакты
  // ---------------------
  String get contacts {
    return _localizedValues[locale.languageCode]['contacts'];
  }
  String get vk {
    return _localizedValues[locale.languageCode]['vk'];
  }
  String get privacypolicy {
    return _localizedValues[locale.languageCode]['privacypolicy'];
  }
  String get phone {
    return _localizedValues[locale.languageCode]['phone'];
  }
  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }
  String get nolessons {
    return _localizedValues[locale.languageCode]['nolessons'];
  }
  String get add {
    return _localizedValues[locale.languageCode]['add'];
  }
  String get addlesson {
    return _localizedValues[locale.languageCode]['addlesson'];
  }
  String get fillintheschedule {
    return _localizedValues[locale.languageCode]['fillintheschedule'];
  }
  String get notdone {
    return _localizedValues[locale.languageCode]['notdone'];
  }
  String get youhavedoneeverything {
    return _localizedValues[locale.languageCode]['youhavedoneeverything'];
  }
  String get january {
    return _localizedValues[locale.languageCode]['January'];
  }
  String get february {
    return _localizedValues[locale.languageCode]['February'];
  }
  String get march {
    return _localizedValues[locale.languageCode]['March'];
  }
  String get april {
    return _localizedValues[locale.languageCode]['April'];
  }
  String get may {
    return _localizedValues[locale.languageCode]['May'];
  }
  String get june {
    return _localizedValues[locale.languageCode]['June'];
  }
  String get july {
    return _localizedValues[locale.languageCode]['July'];
  }
  String get august {
    return _localizedValues[locale.languageCode]['August'];
  }
  String get september {
    return _localizedValues[locale.languageCode]['September'];
  }
  String get october {
    return _localizedValues[locale.languageCode]['October'];
  }
  String get november {
    return _localizedValues[locale.languageCode]['November'];
  }
  String get december {
    return _localizedValues[locale.languageCode]['December'];
  }
  String get nogrades {
    return _localizedValues[locale.languageCode]['nogrades'];
  }
  String get grade {
    return _localizedValues[locale.languageCode]['grade'];
  }
  String get isdone {
    return _localizedValues[locale.languageCode]['isdone'];
  }
  String get whatdidyougetaskedtoday {
    return _localizedValues[locale.languageCode]['whatdidyougetaskedtoday'];
  }
  String get addlessonfirst {
    return _localizedValues[locale.languageCode]['addlessonfirst'];
  }
  String get chooselesson {
    return _localizedValues[locale.languageCode]['chooselesson'];
  }
  String get mon {
    return _localizedValues[locale.languageCode]['mon'];
  }
  String get tue {
    return _localizedValues[locale.languageCode]['tue'];
  }
  String get wed {
    return _localizedValues[locale.languageCode]['wed'];
  }
  String get thu {
    return _localizedValues[locale.languageCode]['thu'];
  }
  String get fri {
    return _localizedValues[locale.languageCode]['fri'];
  }
  String get sat {
    return _localizedValues[locale.languageCode]['sat'];
  }
  String get sun {
    return _localizedValues[locale.languageCode]['sun'];
  }
  String get edit {
    return _localizedValues[locale.languageCode]['edit'];
  }
  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }
  String get titlelesson {
    return _localizedValues[locale.languageCode]['titlelesson'];
  }
  String get teachersfullname {
    return _localizedValues[locale.languageCode]['teachersfullname'];
  }
  String get fillinthefield {
    return _localizedValues[locale.languageCode]['fillinthefield'];
  }
  String get thisisalreadythere {
    return _localizedValues[locale.languageCode]['thisisalreadythere'];
  }
  String get added {
    return _localizedValues[locale.languageCode]['added'];
  }
  String get changed {
    return _localizedValues[locale.languageCode]['changed'];
  }
  String get titleNotification {
    return _localizedValues[locale.languageCode]['titleNotification'];
  }
  String get textNotification {
    return _localizedValues[locale.languageCode]['textNotification'];
  }
  String get shortJanuary {
    return _localizedValues[locale.languageCode]['jan'];
  }
  String get shortFebruary {
    return _localizedValues[locale.languageCode]['feb'];
  }
  String get shortMarch {
    return _localizedValues[locale.languageCode]['mar'];
  }
  String get shortApril {
    return _localizedValues[locale.languageCode]['apr'];
  }
  String get shortMay {
    return _localizedValues[locale.languageCode]['may'];
  }
  String get shortJune {
    return _localizedValues[locale.languageCode]['jun'];
  }
  String get shortJuly {
    return _localizedValues[locale.languageCode]['jul'];
  }
  String get shortAugust {
    return _localizedValues[locale.languageCode]['aug'];
  }
  String get shortSeptember {
    return _localizedValues[locale.languageCode]['sep'];
  }
  String get shortOctober {
    return _localizedValues[locale.languageCode]['oct'];
  }
  String get shortNovember {
    return _localizedValues[locale.languageCode]['nov'];
  }
  String get shortDecember {
    return _localizedValues[locale.languageCode]['dec'];
  }
  String get done {
    return _localizedValues[locale.languageCode]['Done'];
  }
  String get homeworkNotDone {
    return _localizedValues[locale.languageCode]['HomeworkNotDone'];
  }
  String get homeworkDone {
    return _localizedValues[locale.languageCode]['HomeworkDone'];
  }
  String get homeworktooltip {
    return _localizedValues[locale.languageCode]['homeworktooltip'];
  }
  String get edithomeworktooltip {
    return _localizedValues[locale.languageCode]['edithomeworktooltip'];
  }
  String get notdonetooltip {
    return _localizedValues[locale.languageCode]['notdonetooltip'];
  }
  String get subjectstooltip {
    return _localizedValues[locale.languageCode]['subjectstooltip'];
  }
  String get feedback {
    return _localizedValues[locale.languageCode]['feedback'];
  }
  String get today {
    return _localizedValues[locale.languageCode]['today'];
  }
  String get donate {
    return _localizedValues[locale.languageCode]['donate'];
  }
  String get startlesson {
    return _localizedValues[locale.languageCode]['startlesson'];
  }
  String get endlesson {
    return _localizedValues[locale.languageCode]['endlesson'];
  }
}
class DLocalizationsDelegate extends LocalizationsDelegate<DLocalizations> {
  const DLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<DLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DLocalizations.
    return SynchronousFuture<DLocalizations>(DLocalizations(locale));
  }

  @override
  bool shouldReload(DLocalizationsDelegate old) => false;
}
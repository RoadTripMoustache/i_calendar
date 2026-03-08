// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';

class RecurrenceRule extends Equatable {
  static const int defaultInterval = 1;
  static const RecurrenceWeekday defaultStartOfWorkWeek =
      RecurrenceWeekday.monday;

  final RecurrenceFrequency frequency;
  final int interval;
  final RecurrenceWeekday startOfWorkWeek;
  final DateTime? until;
  final int? count;
  final Set<int>? bySeconds;
  final Set<int>? byMinutes;
  final Set<int>? byHours;
  final Set<RecurrenceByDay>? byDays;
  final Set<int>? byMonthDays;
  final Set<int>? byYearDays;
  final Set<int>? byWeekNumbers;
  final Set<int>? byMonths;
  final Set<int>? bySetPositions;

  RecurrenceRule({
    required this.frequency,
    this.interval = defaultInterval,
    this.startOfWorkWeek = defaultStartOfWorkWeek,
    this.until,
    this.count,
    this.bySeconds,
    this.byMinutes,
    this.byHours,
    this.byDays,
    this.byMonthDays,
    this.byYearDays,
    this.byWeekNumbers,
    this.byMonths,
    this.bySetPositions,
  })  : assert(
          until == null || count == null,
          "Until and Count cannot both be provided",
        ),
        assert(interval > 0, "Interval must be positive"),
        assert(
          bySeconds == null || bySeconds.length <= 60,
          "BySecond can only contain up to 60 values",
        ),
        assert(
          bySeconds == null || bySeconds.every((e) => e < 60 && e >= 0),
          "BySecond values must conform to 0 <= x < 60",
        ),
        assert(
          byMinutes == null || byMinutes.length <= 60,
          "ByMinute can only contain up to 60 values",
        ),
        assert(
          byMinutes == null || byMinutes.every((e) => e < 60 && e >= 0),
          "ByMinute values must conform to 0 <= x < 60",
        ),
        assert(
          byHours == null || byHours.length <= 24,
          "ByHour can only contain up to 24 values",
        ),
        assert(
          byHours == null || byHours.every((e) => e < 24 && e >= 0),
          "ByHour values must conform to 0 <= x < 24",
        ),
        assert(
          byMonthDays == null || byMonthDays.length <= 62,
          "ByMonthDay can only contain up to 62 values",
        ),
        assert(
          byMonthDays == null ||
              byMonthDays.every((e) => e <= 31 && e >= 1) ||
              byMonthDays.every((e) => e <= -1 && e >= -31),
          "ByMonthDay values must conform to 1 <= x <= 31 || -31 <= x <= -1",
        ),
        assert(
          byYearDays == null || byYearDays.length <= 732,
          "ByYearDay can only contain up to 732 values",
        ),
        assert(
          byYearDays == null ||
              byYearDays.every((e) => e <= 366 && e >= 1) ||
              byYearDays.every((e) => e <= -1 && e >= -366),
          "ByYearDay values must conform to 1 <= x <= 366 || -366 <= x <= -1",
        ),
        assert(
          byWeekNumbers == null || byWeekNumbers.length <= 106,
          "ByWeekNo can only contain up to 106 values",
        ),
        assert(
          byWeekNumbers == null ||
              byWeekNumbers.every((e) => e <= 53 && e >= 1) ||
              byWeekNumbers.every((e) => e <= -1 && e >= -53),
          "ByWeekNo values must conform to 1 <= x <= 53 || -53 <= x <= -1",
        ),
        assert(
          byMonths == null || byMonths.length <= 12,
          "ByMonth can only contain up to 12 values",
        ),
        assert(
          byMonths == null || byMonths.every((e) => e <= 12 && e >= 1),
          "ByMonth values must conform to 1 <= x <= 12",
        ),
        assert(
          bySetPositions == null || bySetPositions.length <= 732,
          "BySetPos can only contain up to 732 values",
        ),
        assert(
          bySetPositions == null ||
              bySetPositions.every((e) => e <= 366 && e >= 1) ||
              bySetPositions.every((e) => e <= -1 && e >= -366),
          "BySetPos values must conform to 1 <= x <= 366 || -366 <= x <= -1",
        );

  bool get isForever => until == null && count == null;

  @override
  List<Object?> get props => [
        frequency,
        interval,
        startOfWorkWeek,
        until,
        count,
        bySeconds,
        byMinutes,
        byHours,
        byDays,
        byMonthDays,
        byYearDays,
        byWeekNumbers,
        byMonths,
        bySetPositions,
      ];
}

enum RecurrenceFrequency {
  secondly,
  minutely,
  hourly,
  daily,
  weekly,
  monthly,
  yearly,
}

extension RecurrenceFrequencyStringValue on RecurrenceFrequency {
  String get value {
    switch (this) {
      case RecurrenceFrequency.secondly:
        return "SECONDLY";
      case RecurrenceFrequency.minutely:
        return "MINUTELY";
      case RecurrenceFrequency.hourly:
        return "HOURLY";
      case RecurrenceFrequency.daily:
        return "DAILY";
      case RecurrenceFrequency.weekly:
        return "WEEKLY";
      case RecurrenceFrequency.monthly:
        return "MONTHLY";
      case RecurrenceFrequency.yearly:
        return "YEARLY";
    }
  }
}

enum RecurrenceWeekday {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension RecurrenceWeekdayStringValue on RecurrenceWeekday {
  String get value {
    switch (this) {
      case RecurrenceWeekday.sunday:
        return "SU";
      case RecurrenceWeekday.monday:
        return "MO";
      case RecurrenceWeekday.tuesday:
        return "TU";
      case RecurrenceWeekday.wednesday:
        return "WE";
      case RecurrenceWeekday.thursday:
        return "TH";
      case RecurrenceWeekday.friday:
        return "FR";
      case RecurrenceWeekday.saturday:
        return "SA";
    }
  }
}

class RecurrenceByDay extends Equatable {
  final RecurrenceWeekday weekday;
  final int? occurrence;

  const RecurrenceByDay(
    this.weekday, {
    this.occurrence,
  });

  @override
  List<Object?> get props => [weekday, occurrence];
}

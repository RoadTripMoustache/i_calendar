// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../models/recurrence_rule.dart';
import '../values/recurrence_rule.dart';

/// RFC2445 Section 4.8.5.4
class RecurrenceRuleProperty extends CalendarProperty<RecurrenceRuleValue> {
  RecurrenceRuleProperty({
    required RecurrenceFrequency frequency,
    int interval = RecurrenceRule.defaultInterval,
    RecurrenceWeekday startOfWorkWeek = RecurrenceRule.defaultStartOfWorkWeek,
    DateTime? until,
    int? count,
    Set<int>? bySeconds,
    Set<int>? byMinutes,
    Set<int>? byHours,
    Set<RecurrenceByDay>? byDays,
    Set<int>? byMonthDays,
    Set<int>? byYearDays,
    Set<int>? byWeekNumbers,
    Set<int>? byMonths,
    Set<int>? bySetPositions,
  }) : super(
          "RRULE",
          RecurrenceRuleValue(
            frequency: frequency,
            interval: interval,
            startOfWorkWeek: startOfWorkWeek,
            until: until,
            count: count,
            bySeconds: bySeconds,
            byMinutes: byMinutes,
            byHours: byHours,
            byDays: byDays,
            byMonthDays: byMonthDays,
            byYearDays: byYearDays,
            byWeekNumbers: byWeekNumbers,
            byMonths: byMonths,
            bySetPositions: bySetPositions,
          ),
        );

  const RecurrenceRuleProperty.fromValue(RecurrenceRuleValue value)
      : super("RRULE", value);

  factory RecurrenceRuleProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "RRULE",
      "Received invalid property: ${property.name}",
    );

    return RecurrenceRuleProperty.fromValue(
      RecurrenceRuleValue.fromCrawledStringValue(property.value),
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

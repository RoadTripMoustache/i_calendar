// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/date_time.dart';

/// RFC2445 Section 4.8.7.2
class DateTimeStampProperty extends CalendarProperty<DateTimeValue> {
  DateTimeStampProperty(DateTime value)
      : super("DTSTAMP", DateTimeValue(value));

  factory DateTimeStampProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "DTSTAMP",
      "Received invalid property: ${property.name}",
    );

    return DateTimeStampProperty(
      DateTimeValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

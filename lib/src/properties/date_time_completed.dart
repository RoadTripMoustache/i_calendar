// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/date_time.dart';

/// RFC2445 Section 4.8.2.1
class DateTimeCompletedProperty extends CalendarProperty<DateTimeValue> {
  DateTimeCompletedProperty(DateTime value)
      : super("COMPLETED", DateTimeValue(value));

  factory DateTimeCompletedProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "COMPLETED",
      "Received invalid property: ${property.name}",
    );

    return DateTimeCompletedProperty(
      DateTimeValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/utc_offset.dart';

/// RFC2445 Section 4.8.3.4
class TimeZoneOffsetToProperty extends CalendarProperty<UTCOffsetValue> {
  TimeZoneOffsetToProperty(Duration value)
      : super(
          "TZOFFSETTO",
          UTCOffsetValue(value),
        );

  factory TimeZoneOffsetToProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TZOFFSETTO",
      "Received invalid property: ${property.name}",
    );

    return TimeZoneOffsetToProperty(
      UTCOffsetValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/utc_offset.dart';

/// RFC2445 Section 4.8.3.3
class TimeZoneOffsetFromProperty extends CalendarProperty<UTCOffsetValue> {
  TimeZoneOffsetFromProperty(Duration value)
      : super(
          "TZOFFSETFROM",
          UTCOffsetValue(value),
        );

  factory TimeZoneOffsetFromProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TZOFFSETFROM",
      "Received invalid property: ${property.name}",
    );

    return TimeZoneOffsetFromProperty(
      UTCOffsetValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.3.1
class TimeZoneIdentifierProperty extends CalendarProperty<TextValue> {
  TimeZoneIdentifierProperty(String timeZoneIdentifier)
      : super("TZID", TextValue(timeZoneIdentifier));

  factory TimeZoneIdentifierProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TZID",
      "Received invalid property: ${property.name}",
    );

    return TimeZoneIdentifierProperty(
      TextValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

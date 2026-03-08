// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/integer.dart';

/// RFC2445 Section 4.8.1.8
class PercentCompleteProperty extends CalendarProperty<IntegerValue> {
  PercentCompleteProperty(int percent)
      : assert(
          percent >= 0 && percent <= 100,
          "Percent must be a positive integer between 0 and 100",
        ),
        super("PERCENT-COMPLETE", IntegerValue(percent));

  factory PercentCompleteProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "PERCENT-COMPLETE",
      "Received invalid property: ${property.name}",
    );

    return PercentCompleteProperty(
      IntegerValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

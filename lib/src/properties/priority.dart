// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/integer.dart';

/// RFC2445 Section 4.8.1.9
class PriorityProperty extends CalendarProperty<IntegerValue> {
  PriorityProperty(int priority)
      : assert(
          priority >= 0 && priority <= 9,
          "Priority must be a positive integer between 0 and 9",
        ),
        super(
          "PRIORITY",
          IntegerValue(priority),
        );

  factory PriorityProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "PRIORITY",
      "Received invalid property: ${property.name}",
    );

    return PriorityProperty(
      IntegerValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

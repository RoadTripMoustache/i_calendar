// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.7.2
class MethodProperty extends CalendarProperty<TextValue> {
  MethodProperty(String value) : super("METHOD", TextValue(value));

  factory MethodProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "METHOD",
      "Received invalid property: ${property.name}",
    );

    return MethodProperty(
      TextValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

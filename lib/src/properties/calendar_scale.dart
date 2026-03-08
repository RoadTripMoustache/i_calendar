// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.7.1
class CalendarScaleProperty extends CalendarProperty<TextValue> {
  CalendarScaleProperty(CalendarScaleType type)
      : super("CALSCALE", TextValue(type.value));

  factory CalendarScaleProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "CALSCALE",
      "Received invalid property: ${property.name}",
    );

    return CalendarScaleProperty(
      CalendarScaleType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(property.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

enum CalendarScaleType {
  gregorian,
}

extension CalendarScaleTypeStringValue on CalendarScaleType {
  String get value {
    switch (this) {
      case CalendarScaleType.gregorian:
        return "GREGORIAN";
    }
  }
}

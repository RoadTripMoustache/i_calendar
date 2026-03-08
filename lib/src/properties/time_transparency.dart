// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.2.7
class TimeTransparencyProperty extends CalendarProperty<TextValue> {
  TimeTransparencyProperty(TimeTransparencyType type)
      : super("TRANSP", TextValue(type.value));

  factory TimeTransparencyProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TRANSP",
      "Received invalid property: ${property.name}",
    );

    return TimeTransparencyProperty(
      TimeTransparencyType.values.firstWhere(
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

enum TimeTransparencyType {
  opaque,
  transparent,
}

extension TimeTransparencyTypeStringValue on TimeTransparencyType {
  String get value {
    switch (this) {
      case TimeTransparencyType.opaque:
        return "OPAQUE";
      case TimeTransparencyType.transparent:
        return "TRANSPARENT";
    }
  }
}

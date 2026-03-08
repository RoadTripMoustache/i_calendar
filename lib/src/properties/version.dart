// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.7.4
class VersionProperty extends CalendarProperty<TextValue> {
  VersionProperty({
    String minVersion = "2.0",
    String? maxVersion,
  }) : super(
          "VERSION",
          TextValue(
            "$minVersion${maxVersion == null ? "" : ";$maxVersion"}",
          ),
        );

  factory VersionProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "VERSION",
      "Received invalid property: ${property.name}",
    );

    final parts = property.value.split(";");

    return VersionProperty(
      minVersion: parts[0],
      maxVersion: parts.length == 2 ? parts[1] : null,
    );
  }
  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

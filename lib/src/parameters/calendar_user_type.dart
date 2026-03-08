// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.3
class CalendarUserTypeParameter extends CalendarParameter<TextParameterValue> {
  final CalendarUserType type;

  CalendarUserTypeParameter(this.type)
      : super(
          "CUTYPE",
          TextParameterValue(type.value),
        );

  factory CalendarUserTypeParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return CalendarUserTypeParameter(
      CalendarUserType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "CUTYPE";
}

enum CalendarUserType {
  individual,
  group,
  resource,
  room,
  unknown,
}

extension CalendarUserTypeStringValue on CalendarUserType {
  String get value {
    switch (this) {
      case CalendarUserType.individual:
        return "INDIVIDUAL";
      case CalendarUserType.group:
        return "GROUP";
      case CalendarUserType.resource:
        return "RESOURCE";
      case CalendarUserType.room:
        return "ROOM";
      case CalendarUserType.unknown:
        return "UNKNOWN";
    }
  }
}

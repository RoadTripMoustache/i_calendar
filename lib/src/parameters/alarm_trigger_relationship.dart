// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.14
class AlarmTriggerRelationshipParameter
    extends CalendarParameter<TextParameterValue> {
  final AlarmTriggerRelationshipType type;

  AlarmTriggerRelationshipParameter(this.type)
      : super("RELATED", TextParameterValue(type.value));

  factory AlarmTriggerRelationshipParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return AlarmTriggerRelationshipParameter(
      AlarmTriggerRelationshipType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "RELATED";
}

enum AlarmTriggerRelationshipType { start, end }

extension AlarmTriggerRelationshipTypeStringValue
    on AlarmTriggerRelationshipType {
  String get value {
    switch (this) {
      case AlarmTriggerRelationshipType.start:
        return "START";
      case AlarmTriggerRelationshipType.end:
        return "END";
    }
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.13
class RecurrenceIdentifierRangeParameter
    extends CalendarParameter<TextParameterValue> {
  final RecurrenceIdentifierRangeType type;

  RecurrenceIdentifierRangeParameter(this.type)
      : super("RANGE", TextParameterValue(type.value));

  factory RecurrenceIdentifierRangeParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return RecurrenceIdentifierRangeParameter(
      RecurrenceIdentifierRangeType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "RANGE";
}

enum RecurrenceIdentifierRangeType {
  thisAndPrior,
  thisAndFuture,
}

extension RecurrenceIdentifierRangeTypeStringValue
    on RecurrenceIdentifierRangeType {
  String get value {
    switch (this) {
      case RecurrenceIdentifierRangeType.thisAndPrior:
        return "THISANDPRIOR";
      case RecurrenceIdentifierRangeType.thisAndFuture:
        return "THISANDFUTURE";
    }
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.12
class ParticipationStatusParameter
    extends CalendarParameter<TextParameterValue> {
  final ParticipationStatusType type;

  ParticipationStatusParameter(this.type)
      : super("PARTSTAT", TextParameterValue(type.value));

  factory ParticipationStatusParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return ParticipationStatusParameter(
      ParticipationStatusType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "PARTSTAT";
}

enum ParticipationStatusType {
  needsAction,
  accepted,
  declined,
  tentative,
  delegated,
  completed,
  inProcess,
}

extension ParticipationStatusTypeStringValue on ParticipationStatusType {
  String get value {
    switch (this) {
      case ParticipationStatusType.needsAction:
        return "NEEDS-ACTION";
      case ParticipationStatusType.accepted:
        return "ACCEPTED";
      case ParticipationStatusType.declined:
        return "DECLINED";
      case ParticipationStatusType.tentative:
        return "TENTATIVE";
      case ParticipationStatusType.delegated:
        return "DELEGATED";
      case ParticipationStatusType.completed:
        return "COMPLETED";
      case ParticipationStatusType.inProcess:
        return "IN-PROCESS";
    }
  }
}

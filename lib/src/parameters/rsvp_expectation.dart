// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/boolean.dart';

/// RFC2445 Section 4.2.17
class RSVPExpectationParameter
    extends CalendarParameter<BooleanParameterValue> {
  final bool rsvp;

  RSVPExpectationParameter(this.rsvp)
      : super("RSVP", BooleanParameterValue(rsvp));

  factory RSVPExpectationParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return RSVPExpectationParameter(
      BooleanValue.fromCrawledStringValue(parameter.value).value,
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "RSVP";
}

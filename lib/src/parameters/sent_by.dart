// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.2.18
class SentByParameter
    extends CalendarParameter<CalendarUserAddressParameterValue> {
  final String email;

  SentByParameter(this.email)
      : super("SENT-BY", CalendarUserAddressParameterValue(email));

  factory SentByParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return SentByParameter(
      CalendarUserAddressValue.fromCrawledStringValue(parameter.value).value,
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "SENT-BY";
}

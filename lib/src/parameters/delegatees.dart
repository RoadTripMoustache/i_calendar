// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value_list.dart';
import '../calendar_value_list.dart';
import '../models/craweled_parameter.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.2.5
class DelegateesParameter extends CalendarParameter<
    CalendarParameterValueList<CalendarUserAddressParameterValue>> {
  final List<String> emails;

  DelegateesParameter(this.emails)
      : super(
          "DELEGATED-TO",
          CalendarParameterValueList(
            emails.map((e) => CalendarUserAddressParameterValue(e)).toList(),
          ),
        );

  factory DelegateesParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return DelegateesParameter(
      CalendarValueList.fromCrawledStringValue(
        parameter.value,
        (elem) => CalendarUserAddressValue.fromCrawledStringValue(elem),
      ).values.map((e) => e.value).toList(),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "DELEGATED-TO";
}

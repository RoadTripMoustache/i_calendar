// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:email_validator/email_validator.dart';

import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.3
class CalendarUserAddressValue extends CalendarValue<String> {
  const CalendarUserAddressValue(String email)
      : super(email, ValueType.calAddress);

  factory CalendarUserAddressValue.fromCrawledStringValue(String value) =>
      CalendarUserAddressValue(value.substring("MAILTO:".length));

  @override
  void validate() {
    assert(EmailValidator.validate(value), "Email is invalid");
  }

  @override
  String sanitizeToString() {
    return "MAILTO:${value.trim().toLowerCase()}";
  }
}

class CalendarUserAddressParameterValue extends CalendarUserAddressValue
    with CalendarParameterValue {
  CalendarUserAddressParameterValue(String email) : super(email);
}

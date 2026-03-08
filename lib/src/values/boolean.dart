// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.2
class BooleanValue extends CalendarValue<bool> {
  const BooleanValue(bool value) : super(value, ValueType.boolean);

  factory BooleanValue.fromCrawledStringValue(String value) =>
      BooleanValue(value.toUpperCase() == "TRUE");

  @override
  String sanitizeToString() {
    return value ? "TRUE" : "FALSE";
  }
}

class BooleanParameterValue extends BooleanValue with CalendarParameterValue {
  BooleanParameterValue(bool value) : super(value);
}

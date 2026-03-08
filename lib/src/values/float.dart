// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.7
class FloatValue extends CalendarValue<double> {
  const FloatValue(double value) : super(value, ValueType.float);

  factory FloatValue.fromCrawledStringValue(String value) =>
      FloatValue(double.parse(value));
}

class FloatParameterValue extends FloatValue with CalendarParameterValue {
  FloatParameterValue(double value) : super(value);
}

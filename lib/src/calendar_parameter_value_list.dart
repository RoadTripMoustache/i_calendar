// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'calendar_parameter_value.dart';
import 'calendar_value_list.dart';

class CalendarParameterValueList<T extends CalendarParameterValue>
    extends CalendarValueList<T> with CalendarParameterValue {
  CalendarParameterValueList(List<T> values) : super(values);

  @override
  String toString() {
    validate();
    return sanitizeToString();
  }
}

// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';

import 'calendar_parameter_value.dart';

abstract class CalendarParameter<ValueType extends CalendarParameterValue>
    extends Equatable {
  final String parameterName;
  final ValueType value;

  const CalendarParameter(this.parameterName, this.value);

  @override
  String toString() {
    final res = StringBuffer();
    res.write(parameterName.toUpperCase());
    res.write("=");
    res.write(value);
    return res.toString();
  }

  @override
  List<Object?> get props => [parameterName, value];
}

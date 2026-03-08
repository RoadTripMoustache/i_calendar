// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import '../calendar_parameter.dart';
import '../calendar_value.dart';
import '../parameters/inline_encoding.dart';
import '../parameters/value_data_type.dart';

/// RFC2445 Section 4.3.1
class BinaryValue extends CalendarValue<Uint8List> {
  const BinaryValue(Uint8List value) : super(value, ValueType.binary);

  factory BinaryValue.fromCrawledStringValue(String value) =>
      BinaryValue(base64Decode(value));

  @override
  String sanitizeToString() {
    return base64Encode(value);
  }

  @override
  List<CalendarParameter> getInlineParameters() {
    return [
      ValueDataTypeParameter(ValueType.binary),
      InlineEncodingParameter(InlineEncodingType.base64),
    ];
  }
}

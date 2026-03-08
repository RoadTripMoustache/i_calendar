// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.7
class InlineEncodingParameter extends CalendarParameter<TextParameterValue> {
  InlineEncodingParameter(InlineEncodingType type)
      : super("ENCODING", TextParameterValue(type.value));

  factory InlineEncodingParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return InlineEncodingParameter(
      InlineEncodingType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "ENCODING";
}

enum InlineEncodingType {
  eightBit,
  base64,
}

extension InlineEncodingTypeStringValue on InlineEncodingType {
  String get value {
    switch (this) {
      case InlineEncodingType.eightBit:
        return "8BIT";
      case InlineEncodingType.base64:
        return "BASE64";
    }
  }
}

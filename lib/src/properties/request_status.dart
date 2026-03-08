// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/language.dart';
import '../values/float.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.8.2
class RequestStatusProperty extends CalendarProperty<TextValue> {
  final Locale? locale;

  RequestStatusProperty(
    double statusCode,
    String statusDescription, {
    String? extraData,
    this.locale,
  }) : super(
          "REQUEST-STATUS",
          TextValue(
            "${FloatValue(statusCode)};${TextValue(statusDescription)}${extraData == null ? "" : ";${TextValue(extraData)}"}",
            escapeCharacters: false,
          ),
        );

  factory RequestStatusProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "REQUEST-STATUS",
      "Received invalid property: ${property.name}",
    );

    final parts = property.value.split(";");

    return RequestStatusProperty(
      FloatValue.fromCrawledStringValue(parts[0]).value,
      TextValue.fromCrawledStringValue(parts[1]).value,
      extraData: parts.length < 2
          ? null
          : TextValue.fromCrawledStringValue(parts[2]).value,
      locale: property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .map((e) => LanguageParameter.fromCrawledParameter(e))
              .first
              .locale,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (locale != null) LanguageParameter(locale!),
    ];
  }
}

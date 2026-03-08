// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/language.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.3.2
class TimeZoneNameProperty extends CalendarProperty<TextValue> {
  final Locale? locale;

  TimeZoneNameProperty(
    String name, {
    this.locale,
  }) : super("TZNAME", TextValue(name));

  factory TimeZoneNameProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TZNAME",
      "Received invalid property: ${property.name}",
    );

    return TimeZoneNameProperty(
      TextValue.fromCrawledStringValue(property.value).value,
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

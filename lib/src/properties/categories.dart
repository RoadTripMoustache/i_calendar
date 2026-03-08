// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../calendar_value_list.dart';
import '../models/crawled_property.dart';
import '../parameters/language.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.1.2
class CategoriesProperty
    extends CalendarProperty<CalendarValueList<TextValue>> {
  final Locale? locale;

  CategoriesProperty(
    List<String> values, {
    this.locale,
  }) : super(
          "CATEGORIES",
          CalendarValueList(
            values.map((e) => TextValue(e)).toList(),
          ),
        );

  factory CategoriesProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "CATEGORIES",
      "Received invalid property: ${property.name}",
    );

    return CategoriesProperty(
      CalendarValueList.fromCrawledStringValue(
              property.value,
              (stringElement) =>
                  TextValue.fromCrawledStringValue(stringElement))
          .values
          .map((e) => e.value)
          .toList(),
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

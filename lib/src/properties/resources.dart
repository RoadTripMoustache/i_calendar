// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../calendar_value_list.dart';
import '../models/crawled_property.dart';
import '../parameters/alternate_text_representation.dart';
import '../parameters/language.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.1.10
class ResourcesProperty extends CalendarProperty<CalendarValueList<TextValue>> {
  final Uri? alternateTextRepresentation;
  final Locale? locale;

  ResourcesProperty(
    List<String> resources, {
    this.alternateTextRepresentation,
    this.locale,
  }) : super(
          "RESOURCES",
          CalendarValueList(
            resources.map((e) => TextValue(e)).toList(),
          ),
        );

  factory ResourcesProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "RESOURCES",
      "Received invalid property: ${property.name}",
    );

    return ResourcesProperty(
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
      alternateTextRepresentation: property.parameters
              .where(AlternateTextRepresentationParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(AlternateTextRepresentationParameter.testCrawledParameter)
              .map((e) =>
                  AlternateTextRepresentationParameter.fromCrawledParameter(e))
              .first
              .uri,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (alternateTextRepresentation != null)
        AlternateTextRepresentationParameter(alternateTextRepresentation!),
      if (locale != null) LanguageParameter(locale!),
    ];
  }
}
